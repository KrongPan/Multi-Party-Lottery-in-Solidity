// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
	uint public startTimeS1;
    uint public T1;
    uint public N; 
	uint public constant TICKET_PRICE = 0.001 ether;
	uint public numOfUser = 0;

	mapping(address => uint) private userRandNum;

    constructor(uint _N, uint _T1) {
        T1 = _T1 * 1 minutes; //Convert to minutes
		N = _N;
    }

    function Pick_a_number(uint _randNum) public payable {
		if(numOfUser == 0) {
			startTimeS1 = block.timestamp;
		}
        require(block.timestamp < startTimeS1 + T1, "stage 1 is over.");
        require(msg.value == TICKET_PRICE, "Incorrect TICKET_PRICE.");
		require(_randNum >= 0 && _randNum <= 999);
		require(numOfUser < N, "Tickets are sold out.");

		userRandNum[msg.sender] = _randNum;
		numOfUser += 1;
	}
}