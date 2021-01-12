from rest_framework import serializers
from webApp import models
from django.contrib.auth.models import User

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Address
        fields = ['address_id', 'address_description', 'address_lat', 'address_lon']

class CustomerSerializer(serializers.ModelSerializer):
    address = AddressSerializer(read_only=True)
    class Meta:
        model = models.Customer
        fields = ['gender', 'user', 'date_of_birth', 'address', 'imageurl']

class WeightList(serializers.ModelSerializer):
    customer = CustomerSerializer(read_only=True)
    class Meta:
        model = models.Weight 
        fields = ['weight','customer','date_entered']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'first_name', 'last_name', 'email']

    @staticmethod
    def get_basic_fields():
        return 'id', 'first_name', 'last_name'