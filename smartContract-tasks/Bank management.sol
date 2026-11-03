// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BankManagement {
    struct Account {
        uint256 AccountNumber;
        string AccountHolderName;
        uint256 Balance;
        bool ActiveStatus;
        address HolderAddress;
    }

    struct Transaction {
        uint256 fromAccount;
        uint256 toAccount;
        uint256 amount;
        string transactionType;
        uint256 timestamp;
    }

    mapping(uint256 => Account) public accounDetails;
    mapping(uint256 => bool) public accountExists;

    uint256[] public allAccounts;
    Transaction[] public transactions;

    event TransactionRecorded(
        uint256 fromAccount,
        uint256 toAccount,
        uint256 amount,
        string transactionType,
        uint256 timestamp
    );

    receive() external payable {}

    function createAccount(
        uint256 _accountNumber,
        string memory _holderName
    ) public {
        require(_accountNumber != 0, "AccountNumber require");
        require(bytes(_holderName).length > 0, "Name required");
        require(
            !accountExists[_accountNumber],
            "Duplicate account number detected!"
        );
        Account storage account = accounDetails[_accountNumber];
        account.AccountNumber = _accountNumber;
        account.AccountHolderName = _holderName;
        account.Balance = 0;
        account.ActiveStatus = true;
        account.HolderAddress = msg.sender;

        accountExists[_accountNumber] = true;
        allAccounts.push(_accountNumber);
    }

    function closeAccount(uint256 _accountNumber) public {
        Account storage account = accounDetails[_accountNumber];
        require(accountExists[_accountNumber] == true, "Account not found");
        require(account.HolderAddress == msg.sender, "Your are not the owner");
        require(account.ActiveStatus == true, "Account is not activated");
        require(account.Balance == 0, "Withdraw remaining balance first");

        account.ActiveStatus = false;
    }

    function deposit(uint256 amount, uint256 accountNumber) public payable {
        Account storage account = accounDetails[accountNumber];
        require(msg.value == amount, "value mismatch");
        require(accountExists[accountNumber] == true, "Account not found");
        require(account.ActiveStatus == true, "Account is not activated");
        require(amount != 0, "Amount must be greater than zero");

        account.Balance += amount;

        transactions.push(
            Transaction({
                fromAccount: 0,
                toAccount: accountNumber,
                amount: amount,
                transactionType: "Deposit",
                timestamp: block.timestamp
            })
        );

        emit TransactionRecorded(
            0,
            accountNumber,
            amount,
            "Deposit",
            block.timestamp
        );
    }

    function withdraw(
        uint256 amount,
        uint256 accountNumber,
        address to
    ) public {
        Account storage account = accounDetails[accountNumber];
        require(accountExists[accountNumber] == true, "Account not found");
        require(account.HolderAddress == msg.sender, "Your are not the owner");
        require(account.ActiveStatus == true, "Account is not activated");
        require(amount != 0, "Amount must be greater than zero");
        require(to != address(0), "Invalid address");
        require(account.Balance >= amount, "Your account balance is low");

        account.Balance -= amount;
        payable(to).transfer(amount);

        transactions.push(
            Transaction({
                fromAccount: accountNumber,
                toAccount: 0,
                amount: amount,
                transactionType: "Withdraw",
                timestamp: block.timestamp
            })
        );

        emit TransactionRecorded(
            accountNumber,
            0,
            amount,
            "Withdraw",
            block.timestamp
        );
    }

    function transferAmount(uint256 from, uint256 to, uint256 amount) public {
        Account storage senderAccount = accounDetails[from];
        Account storage receiverAccount = accounDetails[to];

        require(accountExists[from], "Sender not found");
        require(accountExists[to], "Receiver not found");

        require(senderAccount.ActiveStatus, "Sender inactive");
        require(receiverAccount.ActiveStatus, "Receiver inactive");

        require(
            senderAccount.HolderAddress == msg.sender,
            "Not the account owner"
        );
        require(amount > 0, "Amount must be greater than zero");
        require(senderAccount.Balance >= amount, "Insufficient balance");
        require(from != to, "Cannot transfer to same account");
        senderAccount.Balance -= amount;
        receiverAccount.Balance += amount;

        transactions.push(
            Transaction({
                fromAccount: from,
                toAccount: to,
                amount: amount,
                transactionType: "Transfer",
                timestamp: block.timestamp
            })
        );

        emit TransactionRecorded(from, to, amount, "Transfer", block.timestamp);
    }

    function getAccount(
        uint256 accountNumber
    ) public view returns (uint, string memory, uint, bool, address) {
        Account storage account = accounDetails[accountNumber];
        require(accountExists[accountNumber], "Account not found");
        return (
            account.AccountNumber,
            account.AccountHolderName,
            account.Balance,
            account.ActiveStatus,
            account.HolderAddress
        );
    }

    function getAllAccount() public view returns (uint256[] memory) {
        return (allAccounts);
    }

    function getTransactionHistory()
        public
        view
        returns (Transaction[] memory)
    {
        return transactions;
    }
}
