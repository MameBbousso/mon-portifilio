from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Enseignant, Responsable, Module, Ressource, Annonce

admin.site.register(Enseignant)
admin.site.register(Responsable)
admin.site.register(Module)
admin.site.register(Ressource)
admin.site.register(Annonce)