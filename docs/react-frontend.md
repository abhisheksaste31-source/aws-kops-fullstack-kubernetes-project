# Switching the frontend to React

```bash
npx create-react-app frontend
```

Replace `frontend/Dockerfile` with:

```dockerfile
FROM node:18 as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM nginx
COPY --from=build /app/build /usr/share/nginx/html
```

Keep API calls relative (`fetch('/api/employees')`) so Ingress routing keeps working.
