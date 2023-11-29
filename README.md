# README

How to run geolocation app 

## Installation

1. create .env file and add variables 

```bash
IPSTACK_ACCESS_KEY=
APPLICATION_SECRET_KEY=
APPLICATION_ACCESS_KEY=
```

2. run docker 

```bash
docker-compose build
docker-compose run web rake db:setup
docker-compose up
```

## Authentication

In order to log into API use /auth/login path with this parametrs

request 

```json
{
    "authentication": { "access_key": "APPLICATION_ACCESS_KEY"  }
}
```

response 

```json
{
    "token": "generated_api_token"
}
```
