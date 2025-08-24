# -------- Stage 1: Build ocov --------
FROM debian:bookworm AS builder

RUN apt-get update && apt-get install -y \
git \
build-essential \
cmake \
curl \
&& rm -rf /var/lib/apt/lists/*

# Clone and build ocov
RUN git clone --recursive https://github.com/C5T/ocov.git /tmp/ocov \
 && cd /tmp/ocov \
 && NDEBUG=1 make .current/ocov

# -------- Stage 2: Final image --------
FROM debian:bookworm-slim

# Install curl (for fetching OPA)
RUN apt-get update && apt-get install -y curl \
&& rm -rf /var/lib/apt/lists/*

# Install OPA (latest release)
RUN curl -L -o /usr/local/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 \
&& chmod +x /usr/local/bin/opa

# Copy ocov binary from builder
COPY --from=builder /tmp/ocov/.current/ocov /usr/local/bin/ocov

WORKDIR /app

COPY policies/ ./policies
COPY tests/ ./tests
COPY test_data/ ./test_data


# Default command just shows versions
CMD ["bash", "-c", "opa version && ocov --help"]