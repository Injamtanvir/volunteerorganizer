@echo off
echo 🚀 Setting up Volunteer Organizer Project...

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed. Please install Node.js first.
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm is not installed. Please install npm first.
    pause
    exit /b 1
)

echo ✅ Node.js and npm are installed

REM Setup Server
echo 📦 Setting up server dependencies...
cd server

REM Install server dependencies
npm install

REM Check if .env exists
if not exist ".env" (
    echo ⚙️ Creating server .env file...
    (
        echo # MongoDB Connection String
        echo MONGODB_URI=mongodb://localhost:27017/volunteer-organizer
        echo.
        echo # JWT Secret Key ^(change this to a secure random string in production^)
        echo JWT_SECRET=your_super_secret_jwt_key_here_change_this_in_production
        echo.
        echo # Server Port
        echo PORT=5000
        echo.
        echo # Frontend URL for CORS
        echo FRONTEND_URL=http://localhost:3000
    ) > .env
    echo ✅ Server .env file created
) else (
    echo ✅ Server .env file already exists
)

cd ..

REM Setup Client
echo 📱 Setting up client dependencies...
cd client

REM Install client dependencies
npm install

REM Fix known vulnerabilities
npm audit fix

REM Install missing babel plugin
npm install --save-dev @babel/plugin-proposal-private-property-in-object

cd ..

echo 🎉 Setup complete!
echo.
echo 🚀 To start the application:
echo 1. Start the server: cd server ^&^& npm run dev
echo 2. Start the client: cd client ^&^& npm start
echo.
echo 📱 Client will be available at: http://localhost:3000
echo 🔗 Server API will be available at: http://localhost:5000
echo.
echo 📋 Make sure MongoDB is running before starting the server!
pause
