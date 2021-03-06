pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

contract Voting {

  mapping(address => bool) public voters;
  mapping(uint => Ballot) public ballots;
  mapping(address => mapping(uint => bool)) public votes;
  address public admin;
  uint public nextBallotId;

  struct Choice{
    uint id;
    string name;
    uint votes;
  }

  struct Ballot {
    uint id;
    string name;
    Choice[] choices;
    uint end;
  }

  constructor() public {
    msg.sender = admin;
  }

  function addVoters(address[] calldata _voters) external onlyAdmin() {
    for(uint i = 0; i < _voters.length; i++) {
      voters[_voters[i]] = true;
    }

  }

  function createBallot(
    string memory name,
    string[] memory choices,
    uint offset
  ) public  onlyAdmin() {
      ballots[nextBallotId].id =nextBallotId;
      ballots[nextBallotId].name = name;
      ballots[nextBallotId].end = now + offset;
      for(uint i = 0; i < choices.length; i++) {
        ballots[nextBallotId].choices.push(Choice(i, choice[i],0));
      }
  }

  function vote(uint ballotId, uint choiceId) external {
    require(voters[msg.sender] == true, "Must be registered");
    require(votes[msg.sender].ballotId == false, "Already voted");
    require(ballots[ballotId].end < now, "Already late");
    votes[msg.sender].ballotId = true;
    ballots[ballotId].choices[choiceId].votes++;
  }

    function results(uint ballotId) 
        view 
        external
        returns(Choice[] memory) {
            return ballots[ballotId].choices;
        }


  modifier onlyAdmin() {
    require(msg.sender == admin, "not allowed");
    _;
  }
}