# Node.js API with PostgreSQL and Custom Logging

This is a simple Node.js application that serves a RESTful API with PostgreSQL integration and custom request logging.

## Features

*   **`/` (GET)**: Checks the database connection status.
*   **`/api/cities` (GET)**: Fetches data from a PostgreSQL table named `citiess`.
*   **Custom Logging**: Logs request duration/latency, path, client IP, HTTP method, status code, and HTTP host header for all incoming requests.
*   **.env for Configuration**: Uses environment variables for sensitive configurations like database credentials and port.

## Prerequisites

Before you begin, ensure you have the following installed:

*   **Node.js 18+**: [Download & Install Node.js](https://nodejs.org/en/download/)
*   **npm** (comes with Node.js)
*   **PostgreSQL 16+**

## Getting Started

Follow these steps to get the project up and running on your local machine.

### 1. Clone the repository

```bash
git clone <repository_url> # Replace with your repository URL
cd citiesple-nodejs-api
```

### 2. Install Dependencies

```bash
npm install
```

This command will install all the necessary packages listed in `package.json` (Express, pg, dotenv).

### 3. Environment Variables Configuration

Create a `.env` file in the root of your project directory (`/home/sya/Documents/Qiscus/citiesple-nodejs-api/.env`). This file will store your database connection details and application port. Replace the placeholder values with your actual PostgreSQL credentials and desired port.

```env
PORT=3000
DB_USER=your_username
DB_HOST=your_host
DB_NAME=your_database_name
DB_PASSWORD=your_password
DB_PORT=5432
```

### 4. Database Setup

This application will get data from a table named `cities` in your PostgreSQL database. If you don't have one, you can create a simple one for testing purposes. Please see the citiesple in the [init_db.sql](./init_db.sql) file.


### 5. Running the Application

To start the application, use one of the following commands:

#### Development Mode (with Nodemon)

This mode uses `nodemon` to automatically restart the server whenever code changes are detected.

```bash
npm run dev
```

#### Using Docker in Development Mode

```bash
docker compose up -d --build
```

Once the server is running, you will see a message like:

```
Server running on port 3000
```

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
    *   **Response**: An array of cities objects.
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

When you make a request to any endpoint, you will see a log entry in your console similar to this:

```
{"timestamp":"2026-01-29T04:28:39.952Z","method":"GET","url":"/favicon.ico","clientIp":"::ffff:172.19.0.1","host":"localhost:3000","status":404,"durationMs":0.378,"userAgent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36"}
```
