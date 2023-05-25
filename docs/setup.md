# 🛠 Installation

Pour pouvoir suivre cet atelier dans des conditions optimales, nous vous proposons plusieurs options de mise en place.

## GitHub Codespaces

**Si vous n'avez pas l'habitude de gérer des environnements virtuels Python sur votre machine**, nous vous conseillons d'utiliser le service [GitHub Codespaces](https://docs.github.com/fr/codespaces). Ce service permet de démarrer un environnement dans un conteneur Docker prêt à l'emploi à partir d'un dépôt GitHub.

!!! tip "Astuce"
    Chaque utilisateur de GitHub bénéficie **gratuitement** de [120 "coeur-heures" et 15 Go de stockage par mois](https://docs.github.com/en/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).
    Ce quota est plus que nécessaire pour réaliser cet atelier dans son intégralité !

Pour démarrer un Codespace avec le [dépôt GitHub de l'atelier](https://github.com/meetup-python-grenoble/datasette-workshop), cliquez sur ce bouton :

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/meetup-python-grenoble/datasette-workshop?quickstart=1)

Une fois l'environnement Codespace initialisé, ouvrir un terminal :

1. Installer Datasette avec `pipx` :
```bash
pipx install datasette
```

2. Installer le support Codespaces pour Datasette :
```bash
datasette install datasette-codespaces
```

3. Démarrer Datasette :
```bash
datasette data/
```

4. Ouvrir l'interface Datasette en cliquant sur l'URL générée (de la forme `https://<username>-<slug>-8001.preview.app.github.dev/`)

### Remarque importante

Après avoir terminé l'atelier, n'oubliez pas [d'éteindre votre Codespace](https://docs.github.com/fr/codespaces/developing-in-codespaces/stopping-and-starting-a-codespace) pour ne pas consommer votre crédit d'utilisation :

- Cliquer sur le bouton en bas à gauche "Codespace" puis "Stop the current Codespace"
- Se rendre sur la [page des Codespaces](https://github.com/codespaces), cliquer sur le menu contextuel du Codespace puis "Arrêter le Codespace"

Vous pouvez ensuite supprimer définitivement votre Codespace si vous le souhaitez (vous perdrez les données générées sur la machine virtuelle).

## Environnement virtuel local

**Si vous êtes familier avec la gestion d'environnements virtuels Python sur votre machine** (en utilisant `venv` + `pip`, `pipenv`, `poetry`, ou `pipx`), vous pouvez installer Datasette comme n'importe quelle autre bibliothèque Python :

1. Cloner le dépôt Git de l'atelier :
```bash
git clone https://github.com/meetup-python-grenoble/datasette-workshop.git
cd datasette-workshop
```

2. Installer Datasette (par exemple, en utilisant `venv` et `pip`) :

Sous Linux ou macOS :
```bash
python3 -m venv venv
source venv/bin/activate
pip install datasette
```

Sous Windows :
```bash
python -m venv venv
.\venv\Scripts\activate
pip install datasette
```

3. Démarrer Datasette :
```bash
datasette data/
```

4. Ouvrir l'interface Datasette avec l'URL locale : [http://127.0.0.1:8001](http://127.0.0.1:8001)
