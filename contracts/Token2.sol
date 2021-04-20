// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "hardhat/console.sol";

contract Token2 {
    
    address test1;

    constructor() {
        balances[msg.sender] = 100;
    }

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    function allowance(address owner, address spender)
        external
        view
        returns (uint256)
    {
        console.log("Variable value is: %s", test1);
        return allowed[owner][spender];
    }

    function approve(address spender, uint256 amount)
        external
        returns (bool)
    {
        require(balances[msg.sender] >= amount);
        require(amount > 0);

        test1 = msg.sender;
        console.log("Variable value is: %s", test1);

        allowed[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        console.log("Variable value is: %s", test1);

        require(
            allowed[sender][recipient] >= amount,
            "You are not allowed to transfer that amount"
        );
        require(balances[sender] >= amount, "Limit exceeded");

        balances[sender] -= amount;
        balances[recipient] += amount;

        allowed[sender][recipient] -= amount;
        return true;
    }
}
