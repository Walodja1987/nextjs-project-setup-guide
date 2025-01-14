#!/bin/bash

# Check if repository name is provided
if [ $# -eq 0 ]; then
    echo "Please provide a repository name"
    echo "Usage: ./setup-nextjs-project.sh <repository-name>"
    exit 1
fi

REPO_NAME=$1

# Check if directory already exists
if [ -d "$REPO_NAME" ]; then
    echo "Error: Directory '$REPO_NAME' already exists"
    echo "Please choose a different name or delete the existing directory"
    exit 1
fi

# Check Node.js version
required_version="18.18.0"
current_version=$(node -v | cut -d 'v' -f 2)

if [ "$(printf '%s\n' "$required_version" "$current_version" | sort -V | head -n1)" != "$required_version" ]; then 
    echo "Node.js version must be >= 18.18.0"
    exit 1
fi

# Create project directory and navigate into it
mkdir "$REPO_NAME"
cd "$REPO_NAME"

# Initialize git
git init

# Create Next.js project with specified options
yarn create next-app . \
    --typescript \
    --tailwind \
    --eslint \
    --src-dir \
    --app \
    --import-alias "@/*" \
    --no-turbopack

# Create .nvmrc
echo "18.18.0" > .nvmrc

# Initialize shadcn
npx shadcn@latest init -y --no-css-variables

# Add common shadcn components
npx shadcn@latest add button -y
npx shadcn@latest add card -y
npx shadcn@latest add progress -y
npx shadcn@latest add table -y

# Install additional dependencies
yarn add recharts clsx tailwind-merge

# Create necessary directories
mkdir -p src/components/{ui,navigation,forms,shared}
mkdir -p src/lib
mkdir -p src/hooks
mkdir -p src/types
mkdir -p src/styles
mkdir -p public/{images,fonts}
mkdir -p tests

# Create utils.ts
cat > src/lib/utils.ts << 'EOL'
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOL

# Create example .env files
touch .env.local
echo "# Example environment variables" > .env.example

# Create basic app structure
mkdir -p src/app/{api,blog,dashboard,"(auth)"/{login,register}}
touch src/app/"(auth)"/login/page.tsx
touch src/app/"(auth)"/register/page.tsx
touch src/app/api/route.ts
touch src/app/blog/page.tsx
touch src/app/dashboard/page.tsx

echo "✅ Project setup complete! Next steps:"
echo "1. cd $REPO_NAME"
echo "2. Create a new repository on GitHub"
echo "3. Connect to GitHub repository:"
echo "   git remote add origin <repository-url>"
echo "   git branch -M main                     # Rename default branch to 'main'"
echo "   git add ."
echo "   git commit -m \"Initial commit\""
echo "   git push -u origin main"
echo "4. yarn dev"
echo "5. Open http://localhost:3000"