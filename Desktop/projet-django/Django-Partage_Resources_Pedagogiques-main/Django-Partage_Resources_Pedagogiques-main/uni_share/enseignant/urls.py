from django.urls import path
from . import views

urlpatterns = [
    path('dashboard/',  views.dashboard,  name='enseignant_dashboard'),
    path('modules/',    views.modules,    name='enseignant_modules'),
    path('ressources/', views.ressources, name='enseignant_ressources'),
]