;; Title: VelocityDAO - Autonomous Treasury Management Protocol

;; Summary:
;; VelocityDAO is a cutting-edge autonomous treasury management protocol that empowers
;; communities to collectively govern digital assets through transparent, democratic
;; decision-making processes on the Stacks blockchain.

;; Description:
;; VelocityDAO revolutionizes decentralized finance by providing a robust infrastructure
;; for community-driven asset management. This protocol enables stakeholders to participate
;; in governance through token-weighted voting, propose strategic initiatives, and execute
;; collective decisions seamlessly. Built with enterprise-grade security and scalability,
;; VelocityDAO features time-locked deposits, anti-spam mechanisms, and automated execution
;; of approved proposals. The system ensures fair representation through proportional voting
;; power while maintaining operational efficiency through optimized smart contract architecture.

;; CONSTANTS & ERROR DEFINITIONS

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-initialized (err u101))
(define-constant err-already-initialized (err u102))
(define-constant err-insufficient-balance (err u103))
(define-constant err-invalid-amount (err u104))
(define-constant err-unauthorized (err u105))
(define-constant err-proposal-not-found (err u106))
(define-constant err-proposal-expired (err u107))
(define-constant err-already-voted (err u108))
(define-constant err-below-minimum (err u109))
(define-constant err-locked-period (err u110))
(define-constant err-transfer-failed (err u111))
(define-constant err-invalid-duration (err u112))
(define-constant err-zero-amount (err u113))
(define-constant err-invalid-target (err u114))
(define-constant err-invalid-description (err u115))
(define-constant err-invalid-proposal-id (err u116))
(define-constant err-invalid-vote (err u117))
(define-constant minimum-duration u144) ;; minimum 1 day (assuming 10min blocks)
(define-constant maximum-duration u20160) ;; maximum 14 days

;; STATE VARIABLES

(define-data-var total-supply uint u0)
(define-data-var minimum-deposit uint u1000000) ;; in microSTX
(define-data-var lock-period uint u1440) ;; ~10 days in blocks
(define-data-var initialized bool false)
(define-data-var last-rebalance uint u0)
(define-data-var proposal-count uint u0)

;; DATA STRUCTURES

;; User token balances
(define-map balances
  principal
  uint
)

;; Deposit tracking with time-lock mechanism
(define-map deposits
  principal
  {
    amount: uint,
    lock-until: uint,
    last-reward-block: uint,
  }
)

;; Governance proposal registry
(define-map proposals
  uint
  {
    proposer: principal,
    description: (string-ascii 256),
    amount: uint,
    target: principal,
    expires-at: uint,
    executed: bool,
    yes-votes: uint,
    no-votes: uint,
  }
)

;; Vote tracking to prevent double voting
(define-map votes
  {
    proposal-id: uint,
    voter: principal,
  }
  bool
)

;; PRIVATE HELPER FUNCTIONS

(define-private (is-contract-owner)
  (is-eq tx-sender contract-owner)
)

(define-private (check-initialized)
  (ok (asserts! (var-get initialized) err-not-initialized))
)