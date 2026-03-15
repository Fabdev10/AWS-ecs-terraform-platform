FROM node:20-alpine

WORKDIR /usr/src/app

COPY package.json ./

# npm install is used here because the repository is being bootstrapped before a lock file exists.
RUN npm install --omit=dev

COPY src ./src

EXPOSE 3000

CMD ["npm", "start"]
