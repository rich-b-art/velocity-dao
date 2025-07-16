# VelocityDAO - Autonomous Treasury Management Protocol

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/rich-b-art/velocity-dao)
[![License](https://img.shields.io/badge/license-ISC-green.svg)](LICENSE)
[![Stacks](https://img.shields.io/badge/blockchain-Stacks-purple.svg)](https://stacks.co)
[![Clarity](https://img.shields.io/badge/language-Clarity-orange.svg)](https://clarity-lang.org)

## 🚀 Overview

VelocityDAO is a cutting-edge autonomous treasury management protocol that empowers communities to collectively govern digital assets through transparent, democratic decision-making processes on the Stacks blockchain. Built with enterprise-grade security and scalability, VelocityDAO provides a robust infrastructure for community-driven asset management.

### Key Features

- **🗳️ Token-Weighted Governance**: Proportional voting power based on stake
- **🔒 Time-Locked Deposits**: Secure asset management with lock periods
- **⚡ Automated Execution**: Seamless execution of approved proposals
- **🛡️ Anti-Spam Protection**: Minimum deposit requirements and voting mechanisms
- **📊 Transparent Operations**: All governance activities are on-chain and auditable
- **⏱️ Flexible Proposal Duration**: Customizable voting periods (1-14 days)

## 🏗️ Architecture

### System Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Stakeholders  │    │   Governance    │    │   Treasury      │
│                 │    │                 │    │                 │
│ • Deposit STX   │───▶│ • Create Props  │───▶│ • Execute Funds │
│ • Vote on Props │    │ • Vote & Count  │    │ • Manage Assets │
│ • Withdraw      │◀───│ • Track Results │◀───│ • Time Locks    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Contract Architecture

The VelocityDAO smart contract is structured with the following components:

#### Core Data Structures

1. **Balances Map**: Tracks token holdings for each user
2. **Deposits Map**: Manages time-locked deposits with reward tracking
3. **Proposals Map**: Stores governance proposals with voting data
4. **Votes Map**: Prevents double-voting and tracks participation

#### State Variables

- `total-supply`: Total tokens in circulation
- `minimum-deposit`: Minimum STX required for participation (1 STX)
- `lock-period`: Time-lock duration (~10 days in blocks)
- `proposal-count`: Sequential proposal identifier

## 📊 Data Flow

### 1. Deposit Process

```
User → deposit(amount) → STX Transfer → Time Lock → Token Minting → Balance Update
```

### 2. Governance Workflow

```
Proposal Creation → Validation → Voting Period → Vote Counting → Execution (if approved)
```

### 3. Withdrawal Process

```
User → withdraw(amount) → Lock Check → Token Burning → STX Transfer → Balance Update
```

## 🔧 Installation & Setup

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) for contract development
- [Node.js](https://nodejs.org/) v16+ for testing
- [Git](https://git-scm.com/) for version control

### Quick Start

1. **Clone the repository**

   ```bash
   git clone https://github.com/rich-b-art/velocity-dao.git
   cd velocity-dao
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Run tests**

   ```bash
   npm test
   ```

4. **Check contract syntax**

   ```bash
   clarinet check
   ```

## 📋 Usage

### Core Functions

#### Administrative Functions

```clarity
;; Initialize the contract (owner only)
(initialize)
```

#### Treasury Management

```clarity
;; Deposit STX and receive DAO tokens
(deposit amount)

;; Withdraw STX after lock period
(withdraw amount)
```

#### Governance Functions

```clarity
;; Create a new proposal
(create-proposal description amount target duration)

;; Vote on a proposal
(vote proposal-id vote-for)

;; Execute an approved proposal
(execute-proposal proposal-id)
```

#### Query Functions

```clarity
;; Get user balance
(get-balance account)

;; Get proposal details
(get-proposal proposal-id)

;; Get deposit information
(get-deposit-info account)
```

### Example Usage

#### Creating a Proposal

```clarity
(create-proposal 
  "Fund community development project" 
  u5000000    ;; 5 STX in microSTX
  'SP1ABC...  ;; Target recipient
  u1440       ;; 1 day voting period
)
```

#### Voting on a Proposal

```clarity
(vote 
  u1    ;; Proposal ID
  true  ;; Vote in favor
)
```

## 🔒 Security Features

### Time-Lock Mechanism

- **Deposit Lock Period**: ~10 days (1,440 blocks)
- **Prevents Immediate Withdrawals**: Ensures commitment to governance

### Anti-Spam Protection

- **Minimum Deposit**: 1 STX required for participation
- **Voting Power**: Proportional to stake size
- **One Vote Per Proposal**: Prevents double voting

### Input Validation

- **Amount Validation**: Prevents zero or negative amounts
- **Duration Limits**: 1-14 day proposal windows
- **Target Validation**: Prevents self-transfers

## 🧪 Testing

The project includes comprehensive test coverage using Vitest and the Clarinet SDK.

### Run Tests

```bash
# Run all tests
npm test

# Run tests with coverage report
npm run test:report

# Watch mode for development
npm run test:watch
```

### Test Coverage

- ✅ Contract initialization
- ✅ Deposit and withdrawal flows
- ✅ Proposal creation and voting
- ✅ Execution of approved proposals
- ✅ Error handling and edge cases
- ✅ Time-lock mechanisms

## 📈 Error Codes

| Code | Error | Description |
|------|-------|-------------|
| 100 | `err-owner-only` | Only contract owner can perform this action |
| 101 | `err-not-initialized` | Contract must be initialized first |
| 102 | `err-already-initialized` | Contract is already initialized |
| 103 | `err-insufficient-balance` | Insufficient balance for operation |
| 104 | `err-invalid-amount` | Invalid amount provided |
| 105 | `err-unauthorized` | User not authorized for this action |
| 106 | `err-proposal-not-found` | Proposal does not exist |
| 107 | `err-proposal-expired` | Proposal voting period has ended |
| 108 | `err-already-voted` | User has already voted on this proposal |
| 109 | `err-below-minimum` | Amount below minimum requirement |
| 110 | `err-locked-period` | Assets are still in lock period |
| 111 | `err-transfer-failed` | STX transfer failed |
| 112 | `err-invalid-duration` | Invalid proposal duration |
| 113 | `err-zero-amount` | Amount cannot be zero |
| 114 | `err-invalid-target` | Invalid target address |
| 115 | `err-invalid-description` | Invalid proposal description |
| 116 | `err-invalid-proposal-id` | Invalid proposal ID |
| 117 | `err-invalid-vote` | Invalid vote value |

## 🛣️ Roadmap

### Phase 1: Core Implementation ✅

- [x] Basic treasury management
- [x] Token-weighted governance
- [x] Time-lock mechanisms
- [x] Comprehensive testing

### Phase 2: Enhanced Features (Planned)

- [ ] Multi-signature proposals
- [ ] Delegation mechanisms
- [ ] Reward distribution system
- [ ] Emergency pause functionality

### Phase 3: Advanced Governance (Future)

- [ ] Quadratic voting
- [ ] Liquid democracy features
- [ ] Integration with other DeFi protocols
- [ ] Mobile-friendly interface

## 🤝 Contributing

We welcome contributions from the community! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Clarity best practices
- Add comprehensive tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the ISC License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Repository**: [https://github.com/rich-b-art/velocity-dao](https://github.com/rich-b-art/velocity-dao)
- **Stacks Blockchain**: [https://stacks.co](https://stacks.co)
- **Clarity Documentation**: [https://clarity-lang.org](https://clarity-lang.org)
- **Clarinet**: [https://github.com/hirosystems/clarinet](https://github.com/hirosystems/clarinet)
