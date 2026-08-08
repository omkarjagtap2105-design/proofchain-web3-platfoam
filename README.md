# ProofChain Web3 Platform

ProofChain is a digital document and credential verification platform that establishes immutable proof of authenticity. Leveraging blockchain (Ethereum/Sepolia) for on-chain anchoring, IPFS for decentralized storage, and Supabase for metadata management, ProofChain guarantees cryptographic security, audit trails, and privacy by design.

---

## Technical Architecture

```
  +------------------+         +------------------+         +--------------------+
  |                  |  REST   |                  |  Sync   |                    |
  |  React Frontend  +-------->+  Express Backend +-------->+ Supabase PostgreSQL|
  |  (Vite, ethers)  |         |  (Node.js, JWT)  |         | (Metadata & RLS)   |
  |                  |         |                  |         |                    |
  +--------+---------+         +--------+---------+         +--------------------+
           |                            |
           | MetaMask Signatures        | Upload / Fetch
           v                            v
  +--------+---------+         +--------+---------+
  |                  |         |                  |
  | Ethereum Network |         |   IPFS Network   |
  | (ProofChain.sol) |         | (Pinata/Infura)  |
  |                  |         |                  |
  +------------------+         +------------------+
```

---

## Project Structure

```
├── blockchain/          # Solidity smart contracts, scripts, and tests (Foundry)
│   ├── src/             # ProofChain.sol
│   ├── test/            # ProofChain.t.sol
│   └── script/          # Deploy.s.sol
├── backend/             # Express.js REST API with Web3 signature auth
│   ├── src/
│   │   ├── controllers/ # Auth, document, and admin controllers
│   │   ├── middleware/  # Auth, role authorization, and error handling
│   │   ├── routes/      # Endpoint route mountings
│   │   └── services/    # IPFS integration service
│   └── package.json
├── frontend/            # Vite + React client app
│   ├── src/
│   │   ├── components/  # Navbar, Sidebar, FileUploader, VerificationStatus
│   │   ├── contexts/    # AuthContext, WalletContext
│   │   ├── pages/       # Landing, Verify, Admin, Issuer, Owner Dashboards
│   │   ├── services/    # api client, blockchain connection, hashing helpers
│   │   └── test/        # Unit testing
│   └── package.json
└── supabase/            # Supabase database schema and migrations
    └── migrations/      # Init schema and Row Level Security (RLS) policies
```

---

## Getting Started

### 1. Smart Contract Layer (Blockchain)
Ensure you have [Foundry](https://book.getfoundry.sh/getting-started/installation) installed.
```bash
cd blockchain
# Compile contract
forge build
# Run contract tests
forge test
```

### 2. Backend Rest API
```bash
cd backend
# Install dependencies
npm install
# Set up environment variables
cp .env.example .env
# Start development server
npm run dev
```

### 3. Frontend dApp Client
```bash
cd frontend
# Install dependencies
npm install
# Run Vite client
npm run dev
# Run frontend unit tests
npm run test
```

---

## Implemented Features

1. **Cryptographic Identity Verification**: Nonce-based signature verification via MetaMask wallets (`ecrecover` on backend) and email/password login.
2. **On-Chain Document Registry**: Smart contract registers document cryptographic hashes to Ethereum with authorization locks.
3. **Decentralized Storage**: Documents are hashed inside the client and archived directly into IPFS.
4. **Row-Level Security (RLS)**: PostgreSQL access policies prevent data tampering, restricting records depending on user role (Admin, Issuer, Owner, Verifier).
5. **Interactive Dashboard**: Custom dark-themed glassmorphism interface with statistics widgets, issuer requests approving tables, verification status, and shareable QR codes.
