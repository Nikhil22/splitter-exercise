pragma solidity ^0.4.4;


contract Splitter {

    event SplitConducted(uint amountSentPerPayee, address[] payeeReceivers);

    modifier mininumAmount(uint amount) {
        require(msg.value >= amount);
        _;
    }

    function split(address[] payees) mininumAmount(payees.length) payable {
        uint amountPerPayee = msg.value / payees.length;
        for (uint i = 0; i < payees.length; i++) {
            payees[i].transfer(amountPerPayee);
        }
        SplitConducted(amountPerPayee, payees);
    }
}
