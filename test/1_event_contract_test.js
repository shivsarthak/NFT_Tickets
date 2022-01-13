var eventContract = artifacts.require('EventContract');
var ticketContract = artifacts.require('TicketContract')

contract('EventContract', function (accounts) {

    it('is deploying correctly', function () {
        return eventContract.deployed().then(function (instance) {
            return instance.getTicketContract();
        }).then(async function (addr) {
            var ticket = await ticketContract.at(addr);
            assert.isNotEmpty(ticket);
        });
    });

    it('is creating an event', function () {
        return eventContract.deployed().then(async function (instance) {
            var myEvents = await instance.getOwnedEvents();
            assert.equal(myEvents.length, 0);
            await instance.createEvent(
                'shivsarthak.com',
                'MINT',
                1);
            myEvents = await instance.getOwnedEvents();
            assert.equal(myEvents.length, 1);
            var event = await instance.getEventDetails(myEvents[0]);
            assert.equal(event[1], 'MINT');
        });
    });

    it('is alloting tickets', async function () {
        return eventContract.deployed().then(async function (instance) {
            var addr = await instance.getTicketContract();
            var ticket = await ticketContract.at(addr);
            var owned_tickets = await ticket.getOwnedTickets();
            assert.equal(owned_tickets.length, 0);
            await instance.buyTickets(0);
            owned_tickets = await ticket.getOwnedTickets();
            assert.equal(owned_tickets.length, 1);
        });
    });
});