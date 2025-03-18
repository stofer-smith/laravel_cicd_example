# Laravel CI/CD Example

Laravel CI/CD Pipeline Example with Kubernetes, ArgoCD, and GitHub Actions

## Build & Run Containers with Podman

From the project root, start the containers:

```bash
podman-compose up -d
```

Verify running containers:

```bash
podman ps
```

## Install Laravel Dependencies

To install Laravel, execute the following inside the app container:

```bash
podman exec -it laravel_app bash
```

On the container run in the app root directory (/var/www/html)

```bash
composer install &&
php artisan key:generate &&
php artisan migrate --seed
```

To stop all containers:

```bash
podman-compose down
```
