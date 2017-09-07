pragma solidity ^0.4.4;

import './Splitter.sol';


contract GroupSplitter is Splitter {
    address[] public participants;

    event ParticipantAdded(address addedParticipant);
    event SplitterKilled(address killer);

    modifier isParticipant() {
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i] == msg.sender) {
                _;
                break;
            }
        }
    }

    function GroupSplitter() {
        // the deployer is the first participant in the splitter
        participants.push(msg.sender);
    }

    function addParticipant(address participant) isParticipant {
        participants.push(participant);
        ParticipantAdded(participant);
    }

    function splitBetweenGroup() payable isParticipant {
        address[] memory payees = new address[](participants.length - 1);
        uint j = 0;
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i] != msg.sender) {
                payees[j] = participants[i];
                j++;
            }
        }
        split(payees);
    }

    function kill() isParticipant {
        // when all participants are deleted nobody can add a participant
        participants = new address[](0);
        SplitterKilled(msg.sender);
    }
}
