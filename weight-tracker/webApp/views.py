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
        queryset = models.Weight.objects.all()
        customer = self.request.query_params.get('customer', None)
        if customer is not None:
            queryset = models.Weight.objects.filter(customer_id=customer).order_by("date_entered").distinct()
        return queryset

class Customer(generics.RetrieveUpdateAPIView):
    serializer_class = serializers.CustomerSerializer
    authentication_class = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        return self.request.user.customer

    def get_queryset(self):
        return models.Customer.objects.none()
