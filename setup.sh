#!/bin/bash

# Volunteer Organizer Setup Script
# This script sets up the entire project for development

echo "🚀 Setting up Volunteer Organizer Project..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Setup Server
echo "📦 Setting up server dependencies..."
cd server

# Install server dependencies
npm install

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "⚙️ Creating server .env file..."
    cat > .env << EOL
# MongoDB Connection String
MONGODB_URI=mongodb://localhost:27017/volunteer-organizer

# JWT Secret Key (change this to a secure random string in production)
JWT_SECRET=your_super_secret_jwt_key_here_change_this_in_production

# Server Port
PORT=5000

# Frontend URL for CORS
FRONTEND_URL=http://localhost:3000
EOL
    echo "✅ Server .env file created"
else
    echo "✅ Server .env file already exists"
fi

cd ..

# Setup Client
echo "📱 Setting up client dependencies..."
cd client

# Install client dependencies
npm install

# Fix known vulnerabilities
npm audit fix

# Install missing babel plugin
npm install --save-dev @babel/plugin-proposal-private-property-in-object

cd ..

echo "🎉 Setup complete!"
echo ""
echo "🚀 To start the application:"
echo "1. Start the server: cd server && npm run dev"
echo "2. Start the client: cd client && npm start"
echo ""
echo "📱 Client will be available at: http://localhost:3000"
echo "🔗 Server API will be available at: http://localhost:5000"
echo ""
echo "📋 Make sure MongoDB is running before starting the server!"
