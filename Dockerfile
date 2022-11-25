# ビルド環境
FROM node:16 as build-stage

WORKDIR /app

# package.json, package-lock.jsonをコピー
COPY package*.json ./

# モジュールのインストール
RUN npm install

COPY ./ .

# ビルド
RUN npm run build

# 本番環境
FROM nginx as production-stage

COPY --from=build-stage /app/dist /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
