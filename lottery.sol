// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./CommitReveal.sol";

contract Lottery is CommitReveal {
	uint public startTime;
    uint public T1;
	uint public T2;
	uint public T3;
    uint public N; 
	uint public constant TICKET_PRICE = 0.001 ether;
	uint16 public numOfUser = 0;
	address payable owner = payable(msg.sender);
	struct Player {
		bytes32 NumHash;
		uint Num;
		uint16 order;
	}

	mapping(address => Player) public player;
	mapping(uint => address) public playerAddress;
    constructor(uint _N, uint _T1, uint _T2, uint _T3) {
        T1 = _T1;
        T2 = _T2;
		T3 = _T3;
		N = _N;
    }

    function Pick_a_number(uint _randNum, uint _salt) public payable {
		if(numOfUser == 0) {
			startTime = block.timestamp;
		}
        require(block.timestamp < startTime + T1, "stage 1 is over.");
        require(msg.value == TICKET_PRICE, "Incorrect TICKET_PRICE.");
		require(numOfUser < N, "Tickets are sold out.");
		player[msg.sender].NumHash = getSaltedHash(bytes32(_randNum), bytes32(_randNum + _salt));
		commit(player[msg.sender].NumHash);
		numOfUser += 1;
		player[msg.sender].order = numOfUser;
		playerAddress[numOfUser] = msg.sender;
	}

	function reveal(uint _randNum, uint _salt) public {
		require(block.timestamp < startTime + T1 + T2 && block.timestamp > startTime + T1, "stage 2 is over/not time yet.");
		revealAnswer(bytes32(_randNum), bytes32(_randNum + _salt));
		player[msg.sender].Num = _randNum;
	}

	function Determine_the_winner() private {
		require(block.timestamp < startTime + T1 + T2 + T3 && block.timestamp > startTime + T1 + T2, "stage 3 is over/not time yet.");
		require(msg.sender == owner);
		uint winnerNum = 0;
		uint16 newN = 0;
		for (uint i=1; i <= N; i++) {
			if(!commits[playerAddress[i]].revealed
			|| (player[playerAddress[i]].Num > 999 || player[playerAddress[i]].Num < 0)) {
				continue; 
			}
			newN++;
			winnerNum ^= player[playerAddress[i]].Num;
			player[playerAddress[i]].order = newN;
			playerAddress[newN] = playerAddress[i];
		}
		N = newN;
		if(N == 0) {
			owner.transfer(0.001 ether * N);
		} else {
			winnerNum %= N;
			address payable winner = payable(playerAddress[winnerNum]);
            winner.transfer(0.00098 ether * N);
            owner.transfer(0.0002 ether * N);
		}
	}

}