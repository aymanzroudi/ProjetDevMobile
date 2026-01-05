<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

# RingSizer

Ce fichier **README unique** documente tout le projet :

- **Backend** : API Laravel (dossier `ringsizer-api`)
- **Frontend** : application Android (dossier/projet Android Studio `RingSizer`)

Objectif : application de bijoux qui permet de mesurer sa taille (bague/bracelet), parcourir un catalogue, gérer favoris + panier, et consulter le cours de l’or.

## Technologies utilisées

### Backend (API)

- **PHP 8.2**
- **Laravel 12**
- **Laravel Sanctum** (authentification par token)
- **MySQL/MariaDB**
- **Eloquent / Migrations**
- Gestion des images via **storage** (`storage/app/public`) + `php artisan storage:link`

### Android

- **Kotlin**
- **Jetpack Compose** (UI)
- **Hilt** (DI)
- **Retrofit + Moshi + OkHttp** (API)
- **Coil** (images)
- **Room** + **DataStore** (stockage local)
- **WorkManager** (tâches background)

## Fonctionnalités principales

- **Rôles** : client / vendeur / admin
- **Catalogue produits** : images, prix, vendeur (shop name), fourchette de taille
- **Filtre "Ma taille"** : optionnel côté client (filtre selon les tailles enregistrées)
- **Mesures** : saisie + sauvegarde côté client
- **Favoris** : ajout/retrait + liste
- **Panier** : ajout/retrait, quantités, total et sous-totaux
- **Cours de l’or** : affichage sur l’app (écran dédié)

## Structure des projets

- `ringsizer-api/` : API Laravel
- `RingSizer/` : application Android (projet Android Studio)

Lors d’un handoff, il faut transmettre **les 2 dossiers**, le **dump SQL**, et le dossier **uploads** (images).

## Démonstration (workflow)

1. Lancer l’API Laravel
2. Lancer l’app Android sur l’émulateur
3. S’inscrire / se connecter
4. Parcourir le catalogue, filtrer, ajouter aux favoris et au panier
5. Aller sur l’écran Mesure pour enregistrer ses tailles

## Installation & exécution sur une nouvelle machine (Windows)

### 1) Backend Laravel (API)

### Prérequis

- PHP 8.2+
- Composer
- MySQL/MariaDB (XAMPP/WAMP acceptable)

### Configuration

1. Installer les dépendances :

   ```bash
   composer install
   ```

2. Créer le fichier `.env` :

   ```bash
   copy .env.example .env
   ```

3. Générer la clé :

   ```bash
   php artisan key:generate
   ```

4. Configurer la base dans `.env` :

   - `DB_DATABASE=ringsizer`
   - `DB_USERNAME=root`
   - `DB_PASSWORD=`

### Base de données (import)

Importer le dump (recommandé via CLI sur Windows, plus fiable que phpMyAdmin) :

```cmd
"C:\xampp\mysql\bin\mysql.exe" -u root -p ringsizer < ringsizer_utf8.sql
```

Si vous êtes dans **PowerShell**, le `<` peut échouer. Dans ce cas :

```powershell
cmd /c ""C:\xampp\mysql\bin\mysql.exe" -u root -p ringsizer < "ringsizer_utf8.sql""
```

### Images / uploads

1. Copier le dossier `storage/app/public/` (ex: `products/`) sur la nouvelle machine.
2. Créer le lien public :

```bash
php artisan storage:link
```

Les images doivent ensuite être accessibles via :

- `http://127.0.0.1:8000/storage/...`

### Lancer le serveur

```bash
php artisan serve --host=0.0.0.0 --port=8000
```

Dans un navigateur (PC) :

- `http://127.0.0.1:8000`

Important : **ne pas** ouvrir `http://0.0.0.0:8000` (c’est une adresse d’écoute, pas une URL à visiter).

### 2) Android (émulateur Android Studio)

### Prérequis

- Android Studio
- SDK Android (compileSdk 34)

### Lancer sur émulateur

1. Démarrer l’API Laravel sur le PC (port 8000)
2. Lancer l’app sur l’émulateur

Pour l’émulateur Android, l’API est accessible via :

- `http://10.0.2.2:8000/`

Dans le code Android, la base URL est définie dans :

- `app/src/main/java/com/example/ringsizer/di/NetworkModule.kt`

Vérification rapide depuis le navigateur de l’émulateur :

- `http://10.0.2.2:8000`

## Notes de maintenance (backend)

- Les routes API sont définies dans `routes/api.php`.
- Les images produits sont servies via `public/storage` (symlink).

## Problèmes fréquents / dépannage

### Import SQL cassé dans phpMyAdmin (encodage)

Sur Windows, une redirection PowerShell `mysqldump ... > file.sql` peut créer un fichier en **UTF-16**.

Solution : générer le dump avec `--result-file` (le fichier restera en UTF-8) :

```powershell
& "C:\xampp\mysql\bin\mysqldump.exe" -u root -p --routines --triggers --single-transaction ringsizer --result-file=ringsizer_utf8.sql
```

### L’API marche sur PC mais pas dans l’émulateur

- Dans l’émulateur, utiliser `10.0.2.2` (pas `localhost`).

## Licence

Ce projet est fourni à des fins éducatives/démonstration. Les dépendances Laravel restent sous licence MIT (voir Laravel).
