# Installation

Pour pouvoir suivre cet atelier dans des conditions optimales, nous vous proposons plusieurs options de mise en place.

## GitHub Codespaces

**Si vous n'avez pas l'habitude de gérer des environnements virtuels Python sur votre machine**, nous vous conseillons d'utiliser le service [GitHub Codespaces](https://docs.github.com/en/codespaces). Ce service permet de démarrer une machine virtuelle prête à l'emploi à partir d'un dépôt Git :

1. Se créer un compte [GitHub](https://github.com)
2. Se rendre sur le dépôt Git de l'atelier : [meetup-python-grenoble/datasette-workshop](https://github.com/meetup-python-grenoble/datasette-workshop)
3. Cliquer sur le bouton "<> Code" puis "Codespaces"
4. Cliquer sur "Créer un codespace sur main" ("Create codespace on main")

Une fois l'environnement Codespace initialisé, ouvrir le terminal :

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
datasette --metadata metadata.yml data.db
```

4. Ouvrir l'interface Datasette en cliquant sur l'URL générée (de la forme `https://<username>-<slug>-8001.preview.app.github.dev/`)

### Remarque importante

Après avoir terminé l'atelier, n'oubliez pas [d'éteindre votre Codespace](https://docs.github.com/fr/codespaces/developing-in-codespaces/stopping-and-starting-a-codespace) pour ne pas consommer votre crédit d'utilisation :

- Cliquer sur le bouton en bas à gauche "Codespace" puis "Stop the current Codespace"
- Se rendre sur la [page des Codespaces](https://github.com/codespaces), cliquer sur le menu contextuel du Codespace puis "Arrêter le Codespace"

Vous pouvez ensuite supprimer définitivement votre Codespace si vous le souhaitez (vous perdrez les données générées sur la machine virtuelle).

## Environnement virtuel local

**Si vous êtes familier avec la gestion d'environnements virtuels Python sur votre machine** (en utilisant `venv` + `pip`, `pipenv`, `poetry`, ou `pipx`), vous pouvez installer Datasette comme n'importe quel autre bibliothèque Python :

1. Cloner le dépôt Git de l'atelier :
```bash
git clone https://github.com/meetup-python-grenoble/datasette-workshop.git
cd datasette-workshop
```

2. Installer Datasette (par exemple, en utilisant `venv` et `pip`) :
```bash
python3 -m venv venv
source venv/bin/activate
pip install datasette
```

3. Démarrer Datasette :
```bash
datasette --metadata metadata.yml data.db
```

4. Ouvrir l'interface Datasette avec l'URL locale : [http://127.0.0.1:8001](http://127.0.0.1:8001)
