# OPA Test Container (with ocov)


This container provides a lightweight environment for testing [Open Policy Agent (OPA)](https://www.openpolicyagent.org/) policies with coverage reporting using [`ocov`](https://github.com/C5T/ocov).

**Special thanks to the authors of the [`ocov`](https://github.com/C5T/ocov) project for making coverage reporting for OPA so accessible and user-friendly. This project would not be possible without their excellent work.**

## Features
- OPA CLI (latest release)
- ocov coverage reporter
- Ready-to-use with your Rego policies, tests, and data

## Build

Build the Docker image (default platform):

```sh
docker build -t opa-ocov .
```

Or for a specific platform (e.g., for multi-arch builds):

```sh
docker build --platform=linux/amd64 -t opa-ocov .
```

## Usage

Run OPA and ocov in the container:

```sh
docker run --rm -it opa-ocov
```

Or start a shell for interactive use:

```sh
docker run --rm -it opa-ocov bash
```

## Running Coverage Reports

To generate a coverage report for your policies:

```sh
opa test <test-paths> --coverage | ocov
```

Or, to save and process coverage from a file:

```sh
opa test <test-paths> --coverage > coverage.json
ocov --input coverage.json
```

Replace `<test-paths>` with your policy/test directories or files.

## Credits

- [ocov](https://github.com/C5T/ocov) by C5T


opa test ${TEST_ARGS} --coverage | ocov


## Old Notes
```
docker build -t opa-ocov .
docker build --platform=linux/amd64 -t opa-ocov .
docker run --rm -it opa-ocov
docker run --rm -it opa-ocov bash
```

