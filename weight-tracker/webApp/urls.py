from django.urls import path
from webApp import views as api_views

urlpatterns = [
    path('weight/',api_views.WeightView.as_view(), name='weight'),
    path('customer/',api_views.Customer.as_view(), name='customer'),
]
