FROM node:25-alpine3.22
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN addgroup -S nodejs && adduser -S nodejs -G nodejs
USER nodejs
ENV NODE_ENV=production
EXPOSE 3000
CMD ["npm", "start"]