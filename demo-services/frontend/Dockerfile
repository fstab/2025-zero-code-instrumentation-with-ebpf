FROM node:24-alpine

COPY frontend.js /
COPY k8s.env /.env

USER node

EXPOSE 8081

CMD ["node", "--env-file", ".env", "/frontend.js" ]
