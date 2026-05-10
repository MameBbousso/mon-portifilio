from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def dashboard(request):
    return render(request, 'etudiant/dashboard.html')

@login_required
def ressources(request):
    return render(request, 'etudiant/ressources.html')

@login_required
def modules(request):
    return render(request, 'etudiant/modules.html')

@login_required
def annonces(request):
    return render(request, 'etudiant/annonces.html')