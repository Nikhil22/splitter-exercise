pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/GroupSplitter.sol";


contract TestGroupSplitter {

    function toString(address x) returns (string) {
        bytes memory b = new bytes(20);
        for (uint i = 0; i < 20; i++)
            b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
        return string(b);
    }

    function testFirstParticipantIsDeployer() {
        GroupSplitter splitter = GroupSplitter(DeployedAddresses.GroupSplitter());

        Assert.equal(tx.origin, splitter.participants(0),  "First participant should be the deployer");
    }

    function testAddParticipant() {
        GroupSplitter splitter = new GroupSplitter();

        address expected = 0x003cf652081b2a13a668ec35e53b30e1692fd426e8;

        splitter.addParticipant(expected);
        address actual = splitter.participants(1);

        Assert.equal(expected, actual, "Added participant is last");
    }
}
