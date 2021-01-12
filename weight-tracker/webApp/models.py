from django.db import models

from django.contrib.auth.models import User
from django.core.validators import URLValidator

# Create your models here.
class Address(models.Model):
    address_id = models.AutoField(primary_key=True)
    address_description = models.CharField(max_length=250,  )    
    address_lat = models.CharField(max_length=30, null=False)
    address_lon = models.CharField(max_length=30, null=False)

class Customer(models.Model):
    GENDER_CHOICES = ( 
        ('M', 'Male'),
        ('F', 'Female'),
    )
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, primary_key=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    date_of_birth = models.DateTimeField(auto_now_add=False)
    user_role = models.CharField(
        max_length=10, db_index=True, null=True)
    address = models.ForeignKey(
        Address, on_delete=models.CASCADE, null=True)
    imageurl = models.TextField(
        validators=[URLValidator()], null=True)
    phone = models.CharField(max_length=24, null=False)

class Weight(models.Model):
    customer = models.ForeignKey(
        Customer, related_name='weights', on_delete=models.CASCADE)
    weight = models.CharField(max_length=30, null=True)
    date_entered = models.DateTimeField(auto_now_add=True)
