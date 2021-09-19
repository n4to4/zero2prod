FROM rust:1.55.0 AS builder
WORKDIR /app
COPY . .
ENV SQLX_OFFLINE true
RUN cargo build --release

FROM rust:1.55.0 AS runtime
COPY --from=builder /app/target/release/zero2prod zero2prod
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT [ "./zero2prod" ]
