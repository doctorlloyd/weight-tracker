from django.urls import path
from webApp import views as api_views

urlpatterns = [
    path('weight/',api_views.WeightView.as_view(), name='weight'),
    path('customer/',api_views.CustomerView.as_view(), name='customer'),
    path('addweight',api_views.AddWeightView.as_view(), name='addweight'),
    path('register/customer/', api_views.RegisterUser.as_view(),name='customer'),
]
