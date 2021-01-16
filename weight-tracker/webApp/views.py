from django.db.models import query_utils
from django.http.response import HttpResponse, JsonResponse
from django.core.serializers import serialize
from django.shortcuts import get_object_or_404, render, redirect, reverse
from rest_framework.response import Response
from webApp import serializers
from webApp.models import Weight, Customer, User
from rest_framework import generics, status
from rest_framework.test import APIClient
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework_jwt.authentication import JSONWebTokenAuthentication


# Create your views here.
class WeightView(generics.ListAPIView):
    authentication_class = (JSONWebTokenAuthentication,)
    permission_classes = (AllowAny,)
    serializer_class = serializers.WeightList

    def get_queryset(self):
        queryset = Weight.objects.all()
        customer = self.request.query_params.get('customer', None)
        if customer is not None:
            queryset = Weight.objects.filter(customer_id=customer).order_by("date_entered").distinct()
        return queryset

class CustomerView(generics.RetrieveUpdateAPIView):
    serializer_class = serializers.CustomerSerializer
    authentication_class = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        return self.request.user.customer

    def get_queryset(self):
        return Customer.objects.none()

class RegisterUser(generics.CreateAPIView):
    serializer_class = serializers.UserSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        queryset = User.objects.get(username=self.request.user.username)
        return queryset

    def post(self, request, *args, **kwargs):
        try:
            request_data = dict(request.data)
            user_data = request_data.get('user')
            username = user_data.get('username')
            email = user_data.get('email')
            password = user_data.get('password')

            user_details = {'username': username,
                            'email': email,
                            'password1': password,
                            'password2': password}

            client = APIClient()
            errors = client.post(
                reverse("register-client"), user_details).json()

            if errors:
                error_list = [
                    {'error_field': error,
                     'error_message': errors.get(error)[0]} for error in errors]
                return Response({"errors": error_list})

        except Exception as ex:
            return Response({"errors": str(ex)})

class AddWeightView(generics.RetrieveUpdateAPIView):
    serializer_class = serializers.WeightList
    authentication_class = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticated,)
    def post(self, request):
        try:
            weight = request.data.get('weight')
            user = request.data.get('customer')
            customer = Customer.objects.get(pk=user)
            weight_object = Weight(customer = customer, weight = weight)
            weight_object.save()
        except Exception as ex:
            print('I failed here: '+str(ex))
        return Response(1, status=status.HTTP_200_OK)

    def delete(self,request):
        entry= Weight.objects.get(weight_id= self.request.query_params.get('weightId'))
        response = entry.delete()
        return Response(response, status=status.HTTP_200_OK)

    def put(self,request):
        response = Weight.objects.filter(pk=request.data.get('weight_id')).update(weight=request.data.get('weight'))
        return Response(response, status=status.HTTP_200_OK)
