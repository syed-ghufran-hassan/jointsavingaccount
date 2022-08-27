pragma solidity ^0.5.0;
contract JointSavings {
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount; 
    uint public contractBalance;

    function withdraw(uint amount, address payable recipient) public { // Defining `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account");
        require(contractBalance>=amount, "Insufficient funds!");
        if (lastToWithdraw != recipient) 
        {
            lastToWithdraw=  recipient;
        }
        recipient.transfer(amount);
        lastWithdrawAmount=amount;
        contractBalance=address(this).balance;
    }

    function deposit() public payable { //Define a `public payable` function named `deposit`.
        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public{   //Defining a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`. 
        accountOne=account1;
        accountTwo=account2;
    }

    function() external payable {} //add the default fallback function so that contract can store Ether sent from outside the deposit function.
}