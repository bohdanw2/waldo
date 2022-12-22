FROM node:16.17.1-bullseye-slim as build

WORKDIR /app-build
COPY . /app-build/
RUN npm install
RUN npm run build

FROM node:16.17.1-bullseye-slim as release

WORKDIR /app
COPY --from=build /app-build/target /app/
COPY --from=build /app-build/node_modules /app/node_modules
EXPOSE 8080

CMD ["node", "./index.js"]