# Node.js API with PostgreSQL and Custom Logging

This is a simple Node.js application that serves a RESTful API with PostgreSQL integration and custom request logging.

## Features

*   **`/` (GET)**: Checks the database connection status.
*   **`/api/cities` (GET)**: Fetches data from a PostgreSQL table named `cities`.
*   **Custom Logging**: Logs request duration/latency, path, client IP, HTTP method, status code, and HTTP host header for all incoming requests.
*   **.env for Configuration**: Uses environment variables for sensitive configurations like database credentials and port.
*   **Docker Support**: Production-ready Docker setup with security best practices.
*   **CI/CD Pipeline**: Automated release builds and deployments to EC2 via GitHub Actions.

## Prerequisites

Before you begin, ensure you have the following installed:

*   **Node.js 18+**: [Download & Install Node.js](https://nodejs.org/en/download/)
*   **npm** (comes with Node.js)
*   **PostgreSQL 16+**
*   **Docker & Docker Compose** (for containerized deployment)

## Getting Started

Follow these steps to get the project up and running on your local machine.

### 1. Clone the repository

```bash
git clone <repository_url>
cd example-nodejs-api
```

### 2. Install Dependencies

```bash
npm install
```

This command will install all the necessary packages listed in [package.json](package.json) (Express, pg, dotenv).

### 3. Environment Variables Configuration

Create a `.env` file in the root of your project directory. This file will store your database connection details and application port. Replace the placeholder values with your actual PostgreSQL credentials and desired port.

```env
PORT=3000
DB_USER=your_username
DB_HOST=localhost
DB_NAME=your_database_name
DB_PASSWORD=your_password
DB_PORT=5432
```

**Note**: The `.env` file is listed in [.gitignore](.gitignore) and will not be committed to version control.

### 4. Database Setup

This application requires a table named `cities` in your PostgreSQL database. You can create and populate it using the [init_db.sql](init_db.sql) file:

```bash
psql -U your_username -d your_database_name -f init_db.sql
```

### 5. Running the Application

#### Development Mode (with Nodemon)

This mode uses `nodemon` to automatically restart the server whenever code changes are detected.

```bash
npm run dev
```

#### Production Mode

```bash
npm start
```

Once the server is running, you will see a message like:

```
Server running on port 3000
```

## Docker Deployment

### Local Development with Docker

```bash
docker compose up -d --build
```

### Production Deployment

This project uses a CI/CD pipeline for automated deployments:

1. **Tag a release**: Push a tag ending with `-release` to trigger the workflow
   ```bash
   git tag v1.0.0-release
   git push origin v1.0.0-release
   ```

2. **Automated Steps**:
   - GitHub Actions builds a Docker image and pushes it to GitHub Container Registry (GHCR)
   - The image is automatically deployed to an EC2 instance
   - Sensitive environment variables (DB credentials) are injected via GitHub Secrets during deployment

See [.github/workflows/release-deploy.yml](.github/workflows/release-deploy.yml) for workflow details.

## API Endpoints

*   **GET /**
    *   **Description**: Checks if the application can successfully connect to the PostgreSQL database.
    *   **Response**: 
        ```json
        {
            "message": "Database connection successful",
            "status": "OK"
        }
        ```
        or in case of error:
        ```json
        {
            "message": "Database connection failed",
            "status": "Error",
            "error": "<error_message>"
        }
        ```

*   **GET /api/cities**
    *   **Description**: Retrieves all entries from the `cities` table.
    *   **Response**: An array of city objects.
        ```json
        [
            {
                "id": 1,
                "state": "California",
                "country": "USA",
                "city_name": "Los Angeles"
            },
            {
                "id": 2,
                "state": "New York",
                "country": "USA",
                "city_name": "New York City"
            }
        ]
        ```
        or in case of error:
        ```json
        {
            "message": "Error fetching cities data",
            "error": "<error_message>"
        }
        ```

## Logging

When you make a request to any endpoint, you will see a log entry in your console:

```json
{"timestamp":"2026-01-29T04:28:39.952Z","method":"GET","url":"/api/cities","clientIp":"::ffff:172.19.0.1","host":"localhost:3000","status":200,"durationMs":5.123,"userAgent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"}
```

Each log entry includes:
- **timestamp**: ISO 8601 format timestamp
- **method**: HTTP method (GET, POST, etc.)
- **url**: Request URL path
- **clientIp**: Client IP address
- **host**: Host header value
- **status**: HTTP response status code
- **durationMs**: Request processing duration in milliseconds
- **userAgent**: User-Agent header

## Project Structure

```
.
├── app.js                          # Main application file
├── package.json                    # Node.js dependencies and scripts
├── Dockerfile                      # Docker image configuration
├── init_db.sql                     # Database initialization script
├── README.md                       # This file
├── .gitignore                      # Git ignore rules
├── .github/
│   └── workflows/
│       └── release-deploy.yml      # CI/CD pipeline configuration
└── deploy/
    └── docker-compose.prod.yml     # Production Docker Compose setup
```

## License

ISC
