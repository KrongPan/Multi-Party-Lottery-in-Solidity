// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./CommitReveal.sol";

contract Lottery is CommitReveal {
	uint public startTime;
    uint public T1;
	uint public T2;
    uint public N; 
	uint public constant TICKET_PRICE = 0.001 ether;
	uint16 public numOfUser = 0;

	struct User {
		bytes32 NumHash;
		uint Num;
		uint16 order;
	}

	mapping(address => User) public user;

    constructor(uint _N, uint _T1, uint _T2) {
        T1 = _T1 * 1 minutes; //Convert to minutes
        T2 = _T2 * 1 minutes;
		N = _N;
    }

	

    function Pick_a_number(uint _randNum, uint _salt) public payable {
		if(numOfUser == 0) {
			startTime = block.timestamp;
		}
        require(block.timestamp < startTime + T1, "stage 1 is over.");
        require(msg.value == TICKET_PRICE, "Incorrect TICKET_PRICE.");
		require(_randNum >= 0 && _randNum <= 999);
		require(numOfUser < N, "Tickets are sold out.");

		user[msg.sender].NumHash = getSaltedHash(bytes32(_randNum), bytes32(_randNum + _salt));
		commit(user[msg.sender].NumHash);
		numOfUser += 1;
		user[msg.sender].order = numOfUser;
	}

	function reveal(uint _randNum, uint _salt) public {
		require(block.timestamp < startTime + T1 + T2 && block.timestamp > startTime + T1, "stage 2 is over/not time yet.");
		revealAnswer(bytes32(_randNum), bytes32(_randNum + _salt));
		user[msg.sender].Num = _randNum;
	}
}
