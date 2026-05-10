from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Administrateur, Notification, HistoriqueAcces

admin.site.register(Administrateur)
admin.site.register(Notification)
admin.site.register(HistoriqueAcces)