// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract PopularSurvey {

    uint256 AGE_ADULT = 18;

    address admin;

    struct Person {
        string name;
        uint256 age;
        bool hasVoted;
    }
    mapping(address => Person) public voters;

    struct Options {
        string option1;
        uint256 counterOption1;
        string option2;
        uint256 counterOption2;
        string option3;
        uint256 counterOption3;
    }
    Options public options;

    modifier isRegistered() {
        require(voters[msg.sender].age != 0, "Complete your registration first");
        _;
    }

    modifier isAdult() {
        require(voters[msg.sender].age >= AGE_ADULT, "Must be adult");
        _;
    }

    constructor() {
        admin = msg.sender;
        options.option1 = "A";
        options.option2 = "B";
        options.option3 = "C";
    }

    function registerVoter(string memory name_, uint256 age_) external {
        require(voters[msg.sender].age == 0, "Already registered");
        voters[msg.sender] = Person(name_, age_, false);
    }

    function vote(string memory selectedOption_) external isRegistered isAdult {
        require( voters[msg.sender].age != 0,  "Complete your registration first");
        require( !voters[msg.sender].hasVoted, "You have already voted" );

        if (keccak256(bytes(selectedOption_)) != keccak256(bytes(options.option1)) && 
            keccak256(bytes(selectedOption_)) != keccak256(bytes(options.option2)) && 
            keccak256(bytes(selectedOption_)) != keccak256(bytes(options.option3))) {
            revert("Not valid option");
        }

        if (keccak256(bytes(selectedOption_)) == keccak256(bytes(options.option1))) {
            options.counterOption1++;
            voters[msg.sender].hasVoted = true;
        } else if (keccak256(bytes(selectedOption_)) == keccak256(bytes(options.option2)) ) {
            options.counterOption2++;
            voters[msg.sender].hasVoted = true;
        } else {
            options.counterOption3++;
            voters[msg.sender].hasVoted = true;
        }
    }

    function viewResults() public view returns(uint256, uint256, uint256) {
        return(options.counterOption1, options.counterOption2, options.counterOption3);
    }

}
