from django.urls import path
from . import views

urlpatterns = [
    path('dashboard/',  views.dashboard,  name='etudiant_dashboard'),
    path('ressources/', views.ressources, name='etudiant_ressources'),
    path('modules/',    views.modules,    name='etudiant_modules'),
    path('annonces/',   views.annonces,   name='etudiant_annonces'),
]