from django.db.models import query_utils
from django.shortcuts import render
from webApp import serializers, models
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework_jwt.authentication import JSONWebTokenAuthentication


# Create your views here.
class WeightView(generics.ListAPIView):
    authentication_class = (JSONWebTokenAuthentication,)
    permission_classes = (AllowAny,)
    serializer_class = serializers.WeightList

    def get_queryset(self):
    #     """
    #     Optionally restricts the returned weights to a given user,
    #     by filtering against a `exercise` query parameter in the URL.
    #     """
        queryset = models.Weight.objects.all()
        customer = self.request.query_params.get('customer', None)

        return queryset

class Customer(generics.RetrieveUpdateAPIView):
    serializer_class = serializers.CustomerSerializer
    authentication_class = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        return self.request.user.customer

    # def get_queryset(self):
    #     return models.Customer.objects.none()
