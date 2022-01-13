// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract TicketContract {
    struct Ticket {
        uint256 ticketID;
        uint256 eventID;
        address ticketOwner;
    }

    address eventContract;
    uint256 ticketCounter;

    modifier onlyEventContract() {
        require(msg.sender == eventContract);
        _;
    }

    mapping(address => uint256[]) ownedTickets;
    mapping(uint256 => Ticket) tickets;

    constructor() {
        eventContract = msg.sender;
        ticketCounter = 0;
    }

    function allotTicket(uint256 eventID, address to) public onlyEventContract {
        uint256 ticketID = ticketCounter;
        ticketCounter = ticketCounter + 1;
        Ticket memory new_ticket = Ticket(ticketID, eventID, to);
        tickets[ticketID] = new_ticket;
        ownedTickets[to].push(ticketID);
    }

    function getOwnedTickets() public view returns (uint256[] memory) {
        return ownedTickets[msg.sender];
    }
}
