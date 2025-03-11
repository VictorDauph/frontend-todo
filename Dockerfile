# Étape 1 : Compilation de l'application Angular
FROM node:18-alpine AS builder
WORKDIR /app

# Copie des fichiers de configuration et installation des dépendances
COPY package*.json ./
RUN npm ci

# Copie du reste du code source
COPY . .

# Compilation de l'application en mode production
RUN npm run build

# Étape 2 : Mise en production avec Nginx
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
# Remplacez "nom-de-votre-app" par le nom réel du dossier généré dans dist/
COPY --from=builder /app/dist/fiche-exercice3-angular/browser /usr/share/nginx/html

# Exposition du port 80
EXPOSE 80

# Démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]


