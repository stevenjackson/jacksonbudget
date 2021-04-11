FROM bitwalker/alpine-elixir-phoenix:1.6.1 as builder

ENV MIX_ENV=prod

WORKDIR /app

# Cache elixir deps
RUN mkdir config
COPY config/* config/
COPY mix.exs mix.lock ./
RUN mix deps.get
RUN mix deps.compile

COPY . /app

RUN mix release --env=prod --verbose

RUN mkdir -p /app/target
RUN find /app/_build/prod/rel/budgets/releases/ -name budgets.tar.gz -exec tar xzf {}  -C /app/target/ \;


# release container
FROM alpine:3.6
ENV MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/sh

#NOTE PORT should be injected

RUN apk add --no-cache bash openssl

COPY --from=builder /app/target /app

# Temp (I think)
COPY balances.txt /app

CMD trap 'exit' INT; app/bin/budgets foreground
