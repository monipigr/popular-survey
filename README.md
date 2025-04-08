# 📊 PopularSurvey

## 📝 Overview

PopularSurvey is a robust blockchain-based voting system implemented as a Solidity smart contract on Ethereum. It features secure age verification and tamper-resistant option tracking for transparent survey results. Developed using Foundry framework for comprehensive testing and security robustness. The system ensures one-vote-per-address while maintaining real-time accessibility of voting outcomes.

## ✨ Features

- 🔐 **Secure Registration**:
  - Unique voter registration with age verification
  - Prevents duplicate registrations
- 🗳️ **Voting Mechanism**:
  - Three fixed voting options (A, B, C)
  - One vote per address enforcement
- 👮 **Age Restriction**:
  - Only adults (≥18 years) can vote
- 📊 **Real-time Results**:
  - Transparent vote counting
  - Immediate results viewing

## 🛠 Technical Details

- **Solidity Version**: `^0.8.24`
- **Testing Framework**: Foundry
- **Key Components**:
  - Voter registration with personal data
  - Tamper-proof vote counting
  - Age verification modifier
  - Results transparency

## 🧪 Comprehensive Test Coverage

### Core Test Suite

| **Test Function**                 | **Key Verification**              |
| --------------------------------- | --------------------------------- |
| `testRegisterVoter()`             | Valid voter registration          |
| `testNotRegisterVoterTwice()`     | Duplicate registration prevention |
| `testVote()`                      | Successful voting flow process    |
| `testVoteNotRegisterUserRevert()` | Unregistered voter blocking       |
| `testVoteNotAdultRevert()`        | Underage voter prevention         |
| `testVoteTwiceRevert()`           | Double voting prevention          |
| `testVoteNotValidOptionRevert()`  | Invalid option detection          |
| `testVoteAndResults()`            | Accurate vote counting            |

### Advanced Fuzz Testing

| **Fuzz Test**             | **Coverage**                   |
| ------------------------- | ------------------------------ |
| `testFuzzVote()`          | Randomized voting scenarios    |
| `testFuzzRegisterVoter()` | Randomized registration inputs |

## 🔧 How to Use

### Prerequisites

- Install Foundry: https://book.getfoundry.sh/

### Installation

```bash
git clone https://github.com/your-repo/popular-survey.git
cd popular-survey
forge install
```

### Testing

```bash
forge test
forge coverage
```

## 📜 License

This project is licensed under the **MIT License** - see the LICENSE file for details.
