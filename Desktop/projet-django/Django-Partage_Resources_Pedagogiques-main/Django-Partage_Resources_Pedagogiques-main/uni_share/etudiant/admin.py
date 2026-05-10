from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Utilisateur, Personne, Classe, Etudiant

admin.site.register(Utilisateur)
admin.site.register(Personne)
admin.site.register(Classe)
admin.site.register(Etudiant)