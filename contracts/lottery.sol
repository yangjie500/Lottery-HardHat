// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

error Lottery__NotEnoughETHEntered();

contract Lottery is VRFConsumerBaseV2 {
  /* State Variables */
  uint256 private immutable i_entraceFee;
  address payable[] private s_players;

  /* Events */
  event LotterEnter(address indexed player);

  constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2){
    i_entraceFee = entranceFee;
  }
  
  function enterRaffle() public payable {
    if (msg.value < i_entraceFee) {revert Lottery__NotEnoughETHEntered();}
    s_players.push(payable(msg.sender));

    // Good idea to emit an event whenever we update a dynamic array or mapping
    // Named events with function name reversed
    emit LotterEnter(msg.sender);
  }

  function requestRandomWinnder() external {
    // Request the random number
    // Once we get it, do something with it
    // 2 transaction process
  }

  function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {}

  /* View / Pure fuctions */
  function getEntraceFee() public view returns (uint256) {
    return i_entraceFee;
  }

  function getPlayer(uint256 index) public view returns(address) {
    return s_players[index];
  }
}

// 14:15