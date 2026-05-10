from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def dashboard(request):
    return render(request, 'administrateur/dashboard.html')

@login_required
def enseignants(request):
    return render(request, 'administrateur/enseignants.html')

@login_required
def classes(request):
    return render(request, 'administrateur/classes.html')

@login_required
def comptes(request):
    return render(request, 'administrateur/comptes.html')