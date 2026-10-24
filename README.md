# Bill8:Checkout - Flutter App

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](../../LICENSE)
[![Built with Flutter](https://img.shields.io/badge/Built%20with-Flutter-blue.svg)](https://flutter.dev/)
[![Docs](https://img.shields.io/badge/docs/read-3aa757.svg)](https://bill8.dev/docs/apps/checkout)
[![Website](https://img.shields.io/badge/website-bill8.dev-1a73e8.svg)](https://bill8.dev)

The hosted payment surface: payment pages and links rendered for the
customer.

## 1. Summary

Bill8:Checkout is the customer-facing Flutter app that renders
hosted payment pages. It serves the page definitions supplied by the
checkout service and completes sessions through the BFF proxy.

## 2. Motivation

Card-handling UI lives in one place - this app - so merchants never
build payment pages. Hosted pages keep card data in one surface and
simplify compliance.

## 3. Architecture & High-Level Design

```mermaid
graph TD
    APP["checkout app (Flutter web)"] --> BFF["Sentin8:BFF"]
    BFF -->|"/proxy/checkout/*"| CHK["Bill8:Checkout"]
    BFF -->|"/proxy/payments/*"| PAY["Bill8:Payments"]
    BFF -->|"/proxy/billing/*"| BI["Bill8:Billing"]
```

## 4. Key Traits and Data Structures

- `Bff8ApiClient` - shared BFF client.
- Page renderer driven by session definitions.

## 5. Rationale, Trade-offs, and Alternatives

- **Hosted over embedded SDK**: one card-handling surface.

## 6. Internal Implementation & Invariants

- All calls route through `Bff8ApiClient`.

## 7. Unresolved Questions / Future Designs

- See the vertical `backlog.md`.

---

**Architecture & Design:** bill8:checkout and its underlying concepts were designed by [Hamid Jahanzad](https://www.linkedin.com/in/hamidjahanzad/).
