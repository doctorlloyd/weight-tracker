from django.contrib import admin
from webApp.models import Address, Customer, Weight
# Register your models here.

class AddressAdmin(admin.ModelAdmin):
    pass

class CustomerAdmin(admin.ModelAdmin):
    pass

class WeightAdmin(admin.ModelAdmin):
    pass

admin.site.register(Address, AddressAdmin)
admin.site.register(Customer, CustomerAdmin)
admin.site.register(Weight, WeightAdmin)