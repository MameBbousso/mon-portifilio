from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from django.contrib.auth.decorators import login_required

@login_required
def dashboard(request):
    return render(request, 'enseignant/dashboard.html')

@login_required
def modules(request):
    return render(request, 'enseignant/modules.html')

@login_required
def ressources(request):
    return render(request, 'enseignant/ressources.html')