# Next.js Project Setup Guide

This guide walks you through setting up a modern Next.js project with a powerful tech stack including:

- **Next.js 14+** with App Router
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **Shadcn UI** for beautiful, accessible components
- **ESLint** for code quality

This setup provides a robust foundation for building scalable web applications with best practices and modern development tools.

## System Requirements

Before you begin, ensure your system meets these requirements:

- **Node.js**: >= 18.18.0 (LTS recommended)
  ```bash
  # Check your Node.js version
  node -v

  # ---------------------------------------------------------------------------------
  # If you don't have Node.js installed, you can install it using the following commands:

  # Option 1: Download from nodejs.org
  # Visit https://nodejs.org and download LTS version
  
  # Option 2: Using nvm (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  nvm install 18.18.0
  nvm use 18.18.0
  ```

- **Git**: Latest version recommended
  ```bash
  # Check your Git version
  git --version
  
  # ---------------------------------------------------------------------------------
  # If you don't have Git installed, you can install it using the following commands:

  # Install Git:
  # On macOS (using Homebrew)
  brew install git
  
  # On Ubuntu/Debian
  sudo apt-get update
  sudo apt-get install git
  
  # On Windows
  # Download from https://git-scm.com/download/win
  ```

- **Yarn**: Latest version (comes with Node.js)
  ```bash
  # Check your Yarn version
  yarn -v
  
  # ---------------------------------------------------------------------------------
  # If you don't have Yarn installed, you can install it using the following commands:

  # Install Yarn globally
  npm install -g yarn
  ```

## Quick Setup

For automated setup, you can use the provided shell script:

```bash
./nextjs-project-setup-guide/setup-nextjs-project.sh my-project
```

> **Note:** Run this command from the parent directory of `nextjs-project-setup-guide`. The script will create a new directory with your project name and set up everything according to this guide.

After running the script, connect your project to GitHub:

1. Create a new repository on GitHub
2. Connect your local repository:
```bash
git remote add origin <repository-url>
git branch -M main
git add .
git commit -m "Initial commit"
git push -u origin main
```

## Manual Setup

### Initial Repository Setup

1. Go to GitHub and create a new repository.

> **Important:** For a smooth Next.js project setup, follow these requirements:
> - Do not initialize with a README since one will be created during Next.js setup. Ensure your repository contains only the `.gitignore` and `.git` files before proceeding.
> - Use lowercase letters without spaces for the repository name (example: use `pm-reporting` instead of `PM-Reporting`)

2. Clone the repository using either GitHub Desktop application or running the following terminal commands (make sure you're in the parent directory where you want your project folder to be created):

```bash
git clone <repository-url>
cd <repository-name>
```

### Node.js

Make sure Node.js version >= 18.18.0 is installed. To check your Node.js version, run:

```bash
node -v
```

For convenience, you can create a `.nvmrc` file and enter the Node.js version there (e.g. `18.18.0`) to automatically use when running `nvm use`.

### Next.js setup

Run the following command to create a Next.js project using TypeScript, Tailwind CSS, and ESLint in the current directory (`.`):

```bash
yarn create next-app .
```

When prompted, answer:

- Would you like to use TypeScript? <span style="color: green">**Yes**</span>
- Would you like to use ESLint? <span style="color: green">**Yes**</span>
- Would you like to use Tailwind CSS? <span style="color: green">**Yes**</span>
- Would you like to use src/ directory? <span style="color: green">**Yes**</span>
- Would you like to use App Router? <span style="color: green">**Yes**</span>
- Would you like to use Turbopack for next dev? <span style="color: red">**No**</span>
- Would you like to customize the default import alias (@/* by default)? <span style="color: red">**No**</span>

If you wish to create the project in a different directory called `my-project`, replace the current directory (`.`) with the desired directory:

```bash
yarn create next-app my-project
```

Then navigate into the directory:

```bash
cd my-project
```

### Shadcn

See docs here: https://ui.shadcn.com/docs/installation/next

```bash
npx shadcn@latest init
```	

(append ` -d` to the command to use the default values).

You can now start adding components to your project.

```bash
npx shadcn@latest add button
```	

Then add the specific shadcn components you're using. For instance:

```bash
npx shadcn@latest add card
npx shadcn@latest add progress
npx shadcn@latest add table
```

For the charts, install recharts:

```bash
yarn add recharts
```


### `utils.ts` file

Create a new file `src/lib/utils.ts` with the following content:

```ts
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
```

Install the required dependencies for the utils file:

```bash
yarn add clsx tailwind-merge
```

### Troubleshooting

- **Project naming restrictions**
  - Problem: "Could not create a project called 'PM-Reporting' because of npm naming restrictions"
  - Solution: Next.js/npm doesn't allow capital letters in the project directory / repository name. Use lowercase letters and hyphens instead (e.g., `pm-reporting`)

- **Node.js version issues**
  - Problem: Incompatible Node.js version errors
  - Solution: Ensure Node.js >= 18.18.0:
    1. Check version: `node -v`
    2. Switch using nvm: `nvm use 18.18.0`
    3. Or download LTS from [nodejs.org](https://nodejs.org)

### Project Structure

Below is the recommended project structure for scalability and maintainability:

```
├── src/                            # Application source code
│   ├── app/                        # Next.js App Router
│   │   ├── (auth)/                 # Auth-related routes (grouped for organizational purposes; this won't appear in URLs)
│   │   │   ├── login/              # Login page accessible at /login (not at /auth/login)
│   │   │   └── register/           # Register page accessible at /register (not at /auth/register)
│   │   ├── api/                    # API routes
│   │   │   ├── users/              # Users API endpoints
│   │   │   │   ├── route.ts        # Users API route handler
│   │   │   │   └── [id]/           # Dynamic user routes
│   │   │   │       └── route.ts    # Dynamic user API route
│   │   │   ├── auth/               # Authentication endpoints
│   │   │   │   ├── login/          # Login endpoints
│   │   │   │   │   └── route.ts    # Login route handler
│   │   │   │   └── signup/         # Signup endpoints
│   │   │   │       └── route.ts    # Signup route handler
│   │   │   └── posts/              # Posts endpoints
│   │   │       └── route.ts        # Posts route handler
│   │   ├── layout.tsx              # Root layout
│   │   ├── page.tsx                # Home / index page accessible at /
│   │   ├── globals.css             # Global styles
│   │   ├── blog/                   # Blog route
│   │   │   ├── layout.tsx          # Optional layout for /blog and its children
│   │   │   ├── page.tsx            # Blog page accessible at /blog
│   │   │   └── [slug]              # Dynamic blog post route
│   │   │       └── page.tsx        # Individual blog post page accessible at /blog/[slug]
│   │   ├── dashboard/              # Dashboard route
│   │   │   ├── page.tsx            # Dashboard page accessible at /dashboard
│   ├── components/                 # React components
│   │   ├── ui/                     # Shadcn components
│   │   ├── navigation/             # Navigation components (navbar, sidebar, etc.)
│   │   ├── forms/                  # Form-related components
│   │   └── shared/                 # Reusable components
│   ├── lib/                        # Utility functions
│   │   ├── utils.ts                # Helper functions
│   │   └── constants.ts            # App constants
│   ├── hooks/                      # Custom React hooks
│   ├── types/                      # TypeScript definitions
│   └── styles/                     # Component styles
├── public/                         # Static assets
│   ├── images/                     # Image files
│   └── fonts/                      # Font files
├── tests/                          # Test files
├── .env.local                      # Local environment variables
├── .env.example                    # Example environment variables
├── tailwind.config.js              # Tailwind configuration
└── tsconfig.json                   # TypeScript configuration
```

#### Special Files in App Router:
- `layout.tsx`: Shared UI for a segment and its children
- `page.tsx`: UI for the route
- `loading.tsx`: Loading UI for a segment
- `error.tsx`: Error UI for a segment
- `not-found.tsx`: Not found UI for a segment
- `route.ts`: API endpoint

#### Key Conventions:
- Use the `src` directory to keep application code separate from configuration files
- Collocate closely related files together in the same directory
- Use route groups (folders with parentheses) to organize routes without affecting the URL structure
- Keep components that are reused across multiple routes in the `components` directory
- Store static assets like images and fonts in the `public` directory


