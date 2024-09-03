pragma solidity ^0.8.19;

contract Coin{
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);
    //Only runs when contraact is deployed
    constructor(){
        minter = msg.sender;
    }   

    //Make new coins + transfer to address
    function mint(address receiver, uint amount) public{
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested, uint available);
    
    function send(address receiver, uint amount) public{
        //If attempt to send more than available cancel transaction
        if(amount > balances[msg.sender])
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }
    

}