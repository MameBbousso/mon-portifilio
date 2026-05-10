from django.urls import path
from . import views

urlpatterns = [
    path('dashboard/',   views.dashboard,   name='admin_dashboard'),
    path('enseignants/', views.enseignants, name='admin_enseignants'),
    path('classes/',     views.classes,     name='admin_classes'),
    path('comptes/',     views.comptes,     name='admin_comptes'),
]