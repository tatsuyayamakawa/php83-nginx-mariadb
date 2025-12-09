# 使用技術
![Laravel](https://img.shields.io/badge/Laravel-10-brightgreen.svg)
![PHP](https://img.shields.io/badge/PHP-8-blue.svg)
![MariaDB](https://img.shields.io/badge/MariaDB-10.4-blue.svg)
![nginx](https://img.shields.io/badge/nginx-1.18-blue.svg)
![Docker](https://img.shields.io/badge/Docker-20.10-blue.svg)
![docker-compose](https://img.shields.io/badge/docker--compose-1.29-blue.svg)


# Laravelプロジェクトの作成方法

1. **cloneする。**  
   プロジェクトのコピーを自分のコンピュータにダウンロードします。
   ```
# Laravel Docker Environment (PHP 8.3 + Nginx + MariaDB)

Docker環境でLaravelを開発するためのセットアップです。

## 構成

- **PHP**: 8.3-FPM (Composer, Node.js 18含む)
- **Nginx**: 最新版
- **MariaDB**: 最新版
- **ポート**: 
  - Nginx: `81` (http://localhost:81)
  - MariaDB: `3306`
  - Vite: `5173`

## セットアップ手順

### 1. 環境変数の設定

`.env` ファイルを作成し、データベース設定を記述してください:

```env
MYSQL_DATABASE=laravel_db
MYSQL_ROOT_PASSWORD=root_password
MYSQL_USER=laravel_user
MYSQL_PASSWORD=laravel_password
TZ=Asia/Tokyo
```

### 2. Laravelプロジェクトの作成

```bash
# Dockerコンテナを起動
docker compose up -d

# PHPコンテナに入る
docker exec -it myapp-php bash

# Laravelプロジェクトを作成
composer create-project laravel/laravel my-app
cd my-app

# パーミッションの確認（自動で設定されます）
ls -la storage
ls -la bootstrap/cache
```

### 3. Laravel環境変数の設定

`my-app/.env` ファイルを編集してデータベース接続を設定:

```env
DB_CONNECTION=mysql
DB_HOST=mariadb
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_user
DB_PASSWORD=laravel_password
```

### 4. アプリケーションの起動

```bash
# マイグレーション実行
php artisan migrate

# （オプション）開発サーバーの起動
# Nginxを使用する場合は不要
php artisan serve --host=0.0.0.0 --port=8000
```

ブラウザで http://localhost:81 にアクセスしてください。

## ディレクトリ構造

```
.
├── docker-compose.yml          # Docker Compose設定
├── docker-config/
│   ├── nginx/
│   │   ├── Dockerfile
│   │   └── default.conf       # Nginx設定
│   ├── php/
│   │   ├── Dockerfile
│   │   ├── entrypoint.sh      # パーミッション自動修正スクリプト
│   │   └── php.ini
│   └── mariadb/
│       └── data/              # データベースデータ（gitignore）
└── my-app/                    # Laravelアプリケーション（gitignore）
```

## 特徴

### 自動パーミッション修正

コンテナ起動時に `entrypoint.sh` スクリプトが自動的に以下のディレクトリのパーミッションを修正します:

- `/var/www/storage`
- `/var/www/bootstrap/cache`
- `/var/www/database`

これにより、Laravelのキャッシュやログ、SQLiteデータベースへの書き込みエラーを防ぎます。

## トラブルシューティング

### パーミッションエラーが発生する場合

```bash
docker exec myapp-php chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/www/database
docker exec myapp-php chmod -R 775 /var/www/storage /var/www/bootstrap/cache /var/www/database
```

### コンテナの再ビルド

```bash
docker compose down
docker compose up -d --build
```

## よく使うコマンド

```bash
# コンテナの起動
docker compose up -d

# コンテナの停止
docker compose down

# PHPコンテナに入る
docker exec -it myapp-php bash

# ログの確認
docker compose logs -f

# Artisanコマンドの実行
docker exec myapp-php php artisan [command]
```
