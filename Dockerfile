FROM node:20 AS builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM node:20 AS runner

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 3000

CMD ["npx", "turbo", "dev"]
