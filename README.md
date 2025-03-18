# laravel_cicd_example
Laravel CI/CD Pipeline Example with Kubernetes, ArgoCD, and GitHub Actions

## Build & Run Containers with Podman

From the project root, start the containers:

'''
podman-compose up -d
'''

Verify running containers:

'''
podman ps
'''

## Install Laravel Dependencies

To install Laravel, execute the following inside the app container:

'''
podman exec -it laravel_app bash
'''

On the container run in the app root directory (/var/www/html)

'''
composer install
php artisan key:generate
php artisan migrate --seed
'''


To stop all containers:
'''
podman-compose down
'''