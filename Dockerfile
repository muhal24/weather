FROM elixir:1.6-alpine
MAINTAINER Alexandre Côté <a.cote@2kloc.com>

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

ENV PORT 4000
ENV MIX_ENV=prod

WORKDIR /weather_api

RUN mix local.hex --force && mix local.rebar --force

COPY mix.* ./
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only-prod

COPY . ./
RUN mix compile

EXPOSE $PORT

CMD ["mix", "phx.server"]
