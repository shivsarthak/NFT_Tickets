// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./TicketContract.sol";

contract EventContract {
    TicketContract ticketContract;
    struct Event {
        uint256 eventID;
        string eventName;
        string eventURI;
        address eventOwner;
    }

    uint256 eventCounter;
    Event[] events;
    mapping(address => uint256[]) ownedEvents;
    mapping(uint256 => uint256) ticketCount;

    modifier ticketsAvailable(uint256 eventID) {
        require(ticketCount[eventID] > 0, "No Tickets Available");
        _;
    }

    constructor() {
        eventCounter = 0;
        ticketContract = new TicketContract();
    }

    function createEvent(
        string memory uri,
        string memory name,
        uint256 tickets
    ) public payable returns (uint256) {
        uint256 eventID = eventCounter;
        eventCounter++;
        Event memory new_event = Event(eventID, name, uri, msg.sender);
        events.push(new_event);
        ticketCount[eventID] = tickets;
        ownedEvents[msg.sender].push(eventID);
        return eventID;
    }

    function buyTickets(uint256 eventID)
        public
        payable
        ticketsAvailable(eventID)
    {
        ticketContract.allotTicket(eventID, msg.sender);
        ticketCount[eventID]--;
    }

    function getOwnedEvents() public view returns (uint256[] memory) {
        return ownedEvents[msg.sender];
    }

    function getTicketContract() public view returns (TicketContract) {
        return ticketContract;
    }

    function getEventDetails(uint256 eventID)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            address
        )
    {
        return (
            events[eventID].eventID,
            events[eventID].eventName,
            events[eventID].eventURI,
            events[eventID].eventOwner
        );
    }
}
