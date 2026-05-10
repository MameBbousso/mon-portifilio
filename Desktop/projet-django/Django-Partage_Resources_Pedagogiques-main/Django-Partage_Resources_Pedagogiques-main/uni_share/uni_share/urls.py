from django.urls import path, include
from django.contrib.auth import views as auth_views
from . import views

urlpatterns = [

    # ── Pages communes ──
    path('',          views.acceuil,  name='home'),
    path('login/',    auth_views.LoginView.as_view(template_name='login.html'),  name='login'),
    path('logout/',   auth_views.LogoutView.as_view(next_page='home'),           name='logout'),
    path('register/', views.register, name='register'),

    # ── Apps ──
    path('etudiant/',       include('etudiant.urls')),
    path('enseignant/',     include('enseignant.urls')),
    path('administrateur/', include('administrateur.urls')),
]