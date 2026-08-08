# Implementation Tasks - ProofChain Web3 Platform

This document outlines the step-by-step task list required to implement the ProofChain Web3 Platform. Tasks are organized into sequential phases, referencing the corresponding requirements from `requirements.md` and correctness properties from `design.md`.

## Phase 1: Blockchain Layer (Foundry Smart Contracts)

- [x] Task 1.1: Initialize Foundry Development Environment
  - **Description**: Scaffold the blockchain development directory using Foundry, configure `foundry.toml`, and install OpenZeppelin Contracts.
  - **Requirements**: Requirement 18
  - **Files**: `blockchain/foundry.toml`, `blockchain/lib/openzeppelin-contracts/`
  - **Expected Outcome**: Foundry is initialized and compiles successfully.

- [x] Task 1.2: Implement ProofChain.sol Smart Contract
  - **Description**: Write the core contract containing document structs, mappings, issuer registration, document registration, revocation, and view functions.
  - **Requirements**: Requirement 6, Requirement 9, Requirement 10
  - **Files**: `blockchain/src/ProofChain.sol`
  - **Expected Outcome**: Smart contract compiled with `forge build`. Meets P5 (Zero Address Rejection).

- [x] Task 1.3: Develop Smart Contract Test Suite
  - **Description**: Write comprehensive unit tests and fuzz tests to verify contract behavior under different inputs.
  - **Requirements**: Requirement 6, Requirement 18
  - **Files**: `blockchain/test/ProofChain.t.sol`
  - **Expected Outcome**: Tests run and pass with `forge test`. Verifies P4 (Issuer Authorization), P5 (Zero Address Rejection), P6 (Revocation Authorization).

- [x] Task 1.4: Implement Deployment and Verification Scripts
  - **Description**: Create Solidity scripts for contract deployment on Sepolia testnet.
  - **Requirements**: Requirement 18, Requirement 21
  - **Files**: `blockchain/script/Deploy.s.sol`
  - **Expected Outcome**: Successful local simulation of contract deployment using forge scripts.

## Phase 2: Database Schema & Access Policies (Supabase PostgreSQL)

- [x] Task 2.1: Define PostgreSQL Schema Migrations
  - **Description**: Create database tables: `users`, `organizations`, `documents`, `verification_logs`, `audit_logs`, `issuer_requests` with constraints, foreign keys, and indexes.
  - **Requirements**: Requirement 16
  - **Files**: `supabase/migrations/20260808000000_init_schema.sql`
  - **Expected Outcome**: PostgreSQL database schema successfully created.

- [x] Task 2.2: Implement Row Level Security (RLS) Policies
  - **Description**: Set up access control policies on all tables so that users can access only their own data or data matching their role.
  - **Requirements**: Requirement 2, Requirement 16
  - **Files**: `supabase/migrations/20260808000001_rls_policies.sql`
  - **Expected Outcome**: RLS policies restrict table actions appropriately. Meets P3 (Role-Based Authorization).

## Phase 3: Backend API Layer (Express.js)

- [x] Task 3.1: Initialize Express Project and Middleware
  - **Description**: Initialize the Express server, configure dotenv, and implement global error handlers and authentication/role authorization middleware.
  - **Requirements**: Requirement 2, Requirement 15, Requirement 19, Requirement 21
  - **Files**: `backend/package.json`, `backend/src/app.js`, `backend/src/middleware/auth.js`, `backend/src/middleware/error.js`
  - **Expected Outcome**: Running Express server with middleware and error-handling logging.

- [x] Task 3.2: Implement Web3 & Traditional Auth Endpoints
  - **Description**: Implement endpoints for nonce generation and cryptographically verifying wallet signatures (ecrecover) to issue session tokens, alongside traditional signup/login.
  - **Requirements**: Requirement 1, Requirement 15
  - **Files**: `backend/src/routes/auth.js`, `backend/src/controllers/authController.js`
  - **Expected Outcome**: Nonce retrieval and signature validation endpoint success. Meets P2 (Signature Verification).

- [x] Task 3.3: Implement IPFS Storage Service
  - **Description**: Implement a service using Multer and an IPFS HTTP client (Pinata/Infura) to upload documents and retrieve files by CID.
  - **Requirements**: Requirement 4, Requirement 15, Requirement 19
  - **Files**: `backend/src/services/ipfsService.js`, `backend/src/routes/ipfs.js`
  - **Expected Outcome**: End-to-end file upload to decentralized storage and CID retrieval.

- [x] Task 3.4: Implement Document and Verification API
  - **Description**: Implement document listing, creation, revocation, verification logs, and public verification endpoints.
  - **Requirements**: Requirement 3, Requirement 5, Requirement 7, Requirement 9, Requirement 11, Requirement 22, Requirement 23
  - **Files**: `backend/src/routes/documents.js`, `backend/src/controllers/documentController.js`
  - **Expected Outcome**: Completed CRUD and verify API endpoints. Meets P7 (Verification Determinism) and P12 (File Upload Hash Search).

- [x] Task 3.5: Implement Administrative & Auditing API
  - **Description**: Implement endpoints for system stats, issuer requests management (approve/reject), role modifications, and audit log retrieval.
  - **Requirements**: Requirement 10, Requirement 13, Requirement 14
  - **Files**: `backend/src/routes/admin.js`, `backend/src/controllers/adminController.js`
  - **Expected Outcome**: Working admin control panel APIs.

## Phase 4: Frontend Development (React & Vite)

- [x] Task 4.1: Scaffold React Project & Theme Setup
  - **Description**: Create the frontend template using Vite, configure index.css with design variables, and implement client-side routing.
  - **Requirements**: Requirement 17, Requirement 20
  - **Files**: `frontend/package.json`, `frontend/src/index.css`, `frontend/src/App.jsx`
  - **Expected Outcome**: React application runs, supports dark theme, and routes load correctly.

- [x] Task 4.2: Implement Auth and Wallet Contexts
  - **Description**: Build React context providers to manage wallet connection state, network validation (Sepolia), and session authorization.
  - **Requirements**: Requirement 1, Requirement 17
  - **Files**: `frontend/src/contexts/AuthContext.jsx`, `frontend/src/contexts/WalletContext.jsx`
  - **Expected Outcome**: React components can consume logged-in user status and wallet address.

- [x] Task 4.3: Implement Core Services & API Clients
  - **Description**: Code the frontend api client, IPFS service, document hashing helper, and blockchain contract integration library (ethers.js).
  - **Requirements**: Requirement 3, Requirement 4, Requirement 5, Requirement 6, Requirement 7, Requirement 23
  - **Files**: `frontend/src/services/blockchain.js`, `frontend/src/services/hashing.js`, `frontend/src/services/api.js`
  - **Expected Outcome**: Frontend can calculate hashes, connect with contracts, and make API requests. Meets P1 (Hash Idempotence) and P11 (File Type Consistency).

- [x] Task 4.4: Design Reusable UI Component Library
  - **Description**: Construct buttons, inputs, file upload zones, cards, modals, notifications, QR code viewer, and status indicators.
  - **Requirements**: Requirement 8, Requirement 19, Requirement 20
  - **Files**: `frontend/src/components/`
  - **Expected Outcome**: Modular components built, fully responsive, and styled. Meets P9 (QR Code Encoding).

- [x] Task 4.5: Implement Public Pages
  - **Description**: Develop Landing page, Login page, Register page, and the public Document Verification workspace (ID search, file upload, QR scan).
  - **Requirements**: Requirement 7, Requirement 8, Requirement 17, Requirement 23
  - **Files**: `frontend/src/pages/Landing.jsx`, `frontend/src/pages/Login.jsx`, `frontend/src/pages/Verify.jsx`
  - **Expected Outcome**: Unauthenticated users can access public routes and perform document checks.

- [x] Task 4.6: Implement Private Dashboards
  - **Description**: Design dashboards for Admin (request approvals, user roles, system metrics), Issuer (issue document form, list of issued files, revocation action), and Document Owner (document cards, QR download, details).
  - **Requirements**: Requirement 11, Requirement 12, Requirement 13, Requirement 14, Requirement 17, Requirement 22
  - **Files**: `frontend/src/pages/admin/`, `frontend/src/pages/issuer/`, `frontend/src/pages/owner/`
  - **Expected Outcome**: Role-restricted views display correct metrics and allow targeted actions.

## Phase 5: Verification & Integration Testing

- [x] Task 5.1: Implement Unit and Service Testing
  - **Description**: Write Vitest unit tests for service helpers, custom hooks, and UI component behavior.
  - **Requirements**: Requirement 25
  - **Files**: `frontend/src/test/`
  - **Expected Outcome**: Unit tests pass successfully.

- [x] Task 5.2: Write Property-Based Tests
  - **Description**: Set up fast-check to verify correctness properties 1-12 across a wide array of generated values.
  - **Requirements**: Requirement 25
  - **Files**: `frontend/src/test/properties/`
  - **Expected Outcome**: All properties fuzzed for 100 runs without error.

- [x] Task 5.3: Develop Integration & E2E Test Suite
  - **Description**: Set up Playwright/Cypress to test end-to-end flows (user signup -> request issuer status -> admin approve -> issuer upload -> blockchain transaction -> public verification).
  - **Requirements**: Requirement 25
  - **Files**: `frontend/e2e/`
  - **Expected Outcome**: Complete flow runs automated in a browser.

- [x] Task 5.4: Documentation and Deployment Guides
  - **Description**: Assemble comprehensive README, architecture specifications, API documentation, deployment blueprints, and troubleshooting guides.
  - **Requirements**: Requirement 25
  - **Files**: `README.md`, `ARCHITECTURE.md`
  - **Expected Outcome**: Fully documented platform ready for deployment.
