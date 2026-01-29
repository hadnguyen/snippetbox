# Snippetbox

A web application for sharing code snippets, built with Go following best practices for structure, testing, and security.

## Features

- Create, view, and manage code snippets
- User authentication and authorization
- Session management with MySQL storage
- CSRF protection
- Secure password hashing with bcrypt
- Responsive UI with custom CSS
- Comprehensive test coverage

## Prerequisites

- Go 1.24.2 or higher
- MySQL 8.0 or higher
- Docker and Docker Compose (optional, for containerized MySQL)

## Installation

1. Clone the repository:

```sh
git clone <repository-url>
cd snippetbox
```

2. Install dependencies:

```sh
go mod download
```

## Database Setup

### Option 1: Using Docker Compose

Start the MySQL container:

```sh
docker-compose up -d --build
```

This will create a MySQL instance with:

- Database: `snippetbox`
- User: `snippetbox`
- Password: `snippetbox`
- Port: `3306`

### Option 2: Local MySQL Installation

1. Create the database and user:

```sh
mysql -u root -p < snippet.sql
```

2. The `snippet.sql` file will:
   - Create the `snippets`, `sessions`, and `users` tables
   - Add necessary indexes and constraints
   - Insert sample data

### Test Database Setup

For running tests, create a test database:

```sh
mysql -u root -p < internal/models/testdata/create-test-database.sql
```

This creates:

- Database: `test_snippetbox`
- User: `test_web`
- Password: `pass`

## Running the Application

### Development Mode

Run the application with default settings:

```sh
go run ./cmd/web
```

The server will start on `http://localhost:4000`

### Custom Configuration

You can customize the server address and database connection:

```sh
go run ./cmd/web -addr=":8080" -dsn="snippetbox:snippetbox@/snippetbox?parseTime=true"
```

**Command-line flags:**

- `-addr`: HTTP network address (default: `:4000`)
- `-dsn`: MySQL data source name (default: `snippetbox:snippetbox@/snippetbox?parseTime=true`)

### Using Air for Live Reload

If you have [Air](https://github.com/cosmtrek/air) installed:

```sh
air
```

This will automatically rebuild and restart the application when you make changes to the code.

## Running Tests

### Run All Tests

```sh
go test ./...
```

### Run Tests with Verbose Output

```sh
go test -v ./...
```

### Run Specific Test Package

```sh
# Test handlers
go test -v ./cmd/web

# Test models
go test -v ./internal/models

# Test validators
go test -v ./internal/validator
```

### Run Specific Test Function

```sh
go test -v -run TestUserSignup ./cmd/web
```

### Run Tests with Coverage

```sh
go test -cover ./...
```

### Generate Coverage Report

```sh
go test -coverprofile=/tmp/profile.out ./...
go tool cover -func=/tmp/profile.out
go tool cover -html=/tmp/profile.out
```

### Skip Integration Tests

Some tests require a database connection. To run only unit tests:

```sh
 go test -v -short ./...
```

## Project Structure

```
snippetbox/
├── cmd/
│   └── web/              # Application entry point and HTTP handlers
│       ├── main.go       # Application initialization
│       ├── handlers.go   # HTTP request handlers
│       ├── helpers.go    # Helper functions
│       ├── middleware.go # HTTP middleware
│       ├── routes.go     # Route definitions
│       ├── templates.go  # Template rendering logic
│       └── *_test.go     # Test files
├── internal/
│   ├── models/           # Data models and database logic
│   │   ├── snippets.go   # Snippet model
│   │   ├── users.go      # User model
│   │   ├── errors.go     # Custom error types
│   │   ├── mocks/        # Mock implementations for testing
│   │   └── testdata/     # Test database setup scripts
│   ├── validator/        # Form validation logic
│   └── assert/           # Test assertion helpers
├── ui/
│   ├── html/             # HTML templates
│   │   ├── base.html     # Base layout template
│   │   ├── pages/        # Page templates
│   │   └── partials/     # Partial templates (nav, etc.)
│   ├── static/           # Static assets
│   │   ├── css/          # Stylesheets
│   │   ├── js/           # JavaScript files
│   │   └── img/          # Images
│   └── efs.go            # Embedded file system
├── docker-compose.yml    # Docker configuration
├── go.mod                # Go module definition
└── snippet.sql           # Database schema and sample data
```

## API Endpoints

### Public Routes

- `GET /` - Home page with latest snippets
- `GET /snippet/view/:id` - View a specific snippet
- `GET /user/signup` - User signup form
- `POST /user/signup` - Process signup
- `GET /user/login` - User login form
- `POST /user/login` - Process login
- `GET /ping` - Health check endpoint

### Protected Routes (require authentication)

- `GET /snippet/create` - Create snippet form
- `POST /snippet/create` - Process new snippet
- `POST /user/logout` - Logout user

## Testing Approach

The application includes comprehensive tests:

- **Unit Tests**: Test individual functions and methods
- **Integration Tests**: Test database interactions
- **HTTP Tests**: Test handlers and middleware
- **Mock Tests**: Use mock implementations to test without database

## Credits

This project is based on the book **["Let's Go" by Alex Edwards](https://lets-go.alexedwards.net/)**, an excellent resource for learning how to build professional web applications with Go.

Highly recommended for anyone learning Go web development!

## License

This project is for educational purposes.
