# Hardcore Handyman

https://hardcorehandyman.fly.dev/

A modern, full-stack web application built for a local handyman business, enabling customers to request quotes and seamlessly communicate project details through an intuitive interface.

## 🎯 Project Overview

This production-ready Phoenix application streamlines the quote request process for handyman services. Customers can submit detailed project information, upload photos and documents, and receive professional quotes—all through a responsive, real-time web interface.

## ✨ Key Features

- **Real-Time Quote Requests**: Built with Phoenix LiveView for instant, reactive user experiences without page reloads
- **File Upload System**: Multi-file upload capability allowing customers to share project photos and documents for accurate quotes
- **Form Validation**: Client and server-side validation with phone number formatting using libphonenumber
- **Responsive Design**: Mobile-first UI built with TailwindCSS for seamless experience across all devices
- **Database Integration**: PostgreSQL-backed data persistence with Ecto for reliable quote management
- **Email Notifications**: Automated email system using Phoenix.Mailer to notify business owner of new quote requests
- **Production Deployment**: Containerized with Docker and configured for Fly.io deployment

## 🛠️ Tech Stack

**Backend:**
- Elixir & Phoenix Framework
- Phoenix LiveView for real-time interactivity
- Ecto for database ORM
- PostgreSQL database

**Frontend:**
- Phoenix LiveView (server-rendered with live updates)
- TailwindCSS for styling
- JavaScript hooks for enhanced UX (date pickers, file uploads)
- Flatpickr for date selection

**DevOps:**
- Docker containerization
- Fly.io deployment configuration
- ASDF for version management

## 🚀 Getting Started

**Prerequisites:**
- Elixir 1.14+
- Erlang/OTP 25+
- PostgreSQL 14+
- Node.js 18+ (for asset compilation)

**Installation:**

```bash
# Install dependencies
mix setup

# Start the Phoenix server
mix phx.server

# Or run inside IEx for interactive development
iex -S mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) to view the application.

## 📁 Project Structure

```
lib/
├── hardcorehandyman/          # Business logic & contexts
│   └── quotes/                # Quote request management
├── hardcorehandyman_web/      # Web interface layer
│   ├── live/                  # LiveView modules
│   ├── components/            # Reusable UI components
│   └── controllers/           # HTTP controllers
assets/                        # Frontend assets
priv/repo/migrations/          # Database migrations
```

## 🎨 Technical Highlights

- **LiveView Architecture**: Leverages Phoenix LiveView for SPA-like experience with server-side rendering benefits
- **Component-Based UI**: Modular, reusable components following Phoenix 1.7+ conventions
- **Database Schema Design**: Normalized schema with migrations for data integrity
- **Custom CSS Pipeline**: Optimized asset pipeline with TailwindCSS purging for minimal bundle size
- **Testing Suite**: Comprehensive test coverage with ExUnit

## 🌐 Deployment

The application is containerized and configured for cloud deployment:

- `Dockerfile` for consistent containerization
- `fly.toml` for Fly.io platform configuration
- Database migration scripts in `rel/overlays/bin/`
- Production secrets management via runtime configuration

## 📚 Development Notes

- [Where to get SSL](https://certbot.eff.org/)
- [Free domains](https://www.freenom.com/en/index.html?lang=en)
- [Nice guide on deploying](https://damonvjanis.medium.com/optimizing-for-free-hosting-elixir-deployments-6bfc119a1f44)

## 📖 Additional Resources

- [Phoenix Framework Documentation](https://hexdocs.pm/phoenix)
- [Phoenix LiveView Guide](https://hexdocs.pm/phoenix_live_view)
- [Elixir Forum](https://elixirforum.com/c/phoenix-forum)
