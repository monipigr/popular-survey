// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PopularSurvey} from "../src/PopularSurvey.sol";

contract PopularSurveyTest is Test {
    
    PopularSurvey public survey;
    address public admin = vm.addr(1);
    address public user1 = vm.addr(2);
    address public user2 = vm.addr(3);
    address public user3 = vm.addr(4);

    function setUp() public {
        survey = new PopularSurvey();
    }

    // Comprueba que un usuario puede registarse correctamente 
    function testRegisterVoter() public {
        string memory name_ = "Bob";
        uint256 age_ = 25;
        bool hasVoted_ = false;

        vm.startPrank(user1);
        survey.registerVoter(name_, age_);
        (string memory name, uint256 age, bool hasVoted) = survey.voters(user1);
        assertEq(keccak256(bytes(name)), keccak256(bytes(name_)), "Not matching name" );
        assertEq(age, age_, "Not matching age");
        assertEq(hasVoted, hasVoted_, "Not matching hasVoted");
        vm.stopPrank();
    }

    // Comprueba que un usuario no puede registarse dos veces con la misma dirección
    function testNotRegisterVoterTwice() public {
        string memory name_ = "Alice";
        uint256 age_ = 34;

        vm.startPrank(user2);
        survey.registerVoter(name_, age_);
        vm.expectRevert();
        survey.registerVoter(name_, age_);
        vm.stopPrank();
    }

    // Testea que un usuario puede votar 
    function testVote() public{
        string memory name_ = "Bob";
        uint256 age_ = 34;
        string memory option_ = "A";

        vm.startPrank(user1);
        (,, bool hasVotedInitial) = survey.voters(user1);
        assertFalse(hasVotedInitial);
        survey.registerVoter(name_, age_);
        survey.vote(option_);
        (,, bool hasVoted) = survey.voters(user1);
        assertTrue(hasVoted);
        (uint a1,,) = survey.viewResults();
        assertEq(a1, 1, "Not matching counter");
        vm.stopPrank();
    }

    // Testea que el usuario no puede votar si no se ha registrado previamente 
    function testVoteNotRegisterUserRevert() public {
        vm.startPrank(user1);
        vm.expectRevert();
        survey.vote('A');
        vm.stopPrank();
    }
    
    // Testea que el usuario no puede votar si no es adulto
    function testVoteNotAdultRevert() public {
        string memory name_ = "Alice";
        uint256 age_ = 16;
        string memory option_ = "B";

        vm.startPrank(user1);
        survey.registerVoter(name_, age_);
        vm.expectRevert();
        survey.vote(option_);
        vm.stopPrank();
    }

    // Testea que un usuario no puede votar dos veces
    function testVoteTwiceRevert() public {
        string memory name_ = "Bob";
        uint256 age_ = 45;
        string memory option_ = "A";
        string memory option2_ = "B";

        vm.startPrank(user1);
        survey.registerVoter(name_, age_);
        survey.vote(option_);
        vm.expectRevert();
        survey.vote(option2_);
        vm.stopPrank();
    }

    // Testea que el usuario no puede votar una opción inválida
    function testVoteNotValidOptionRevert() public {
        string memory name_ = "Alice";
        uint256 age_ = 37;
        string memory option_ = "D";

        vm.startPrank(user2);
        survey.registerVoter(name_, age_);
        vm.expectRevert();
        survey.vote(option_);
        vm.stopPrank();
    }


    // Testea que el contador de opciones funciona correctamente
    function testVoteAndResults() public {
        vm.startPrank(user1);
        survey.registerVoter("Bob", 18);
        survey.vote("A");
        vm.stopPrank();

         vm.startPrank(user2);
        survey.registerVoter("Alice", 29);
        survey.vote("B");
        vm.stopPrank();

         vm.startPrank(user3);
        survey.registerVoter("John", 44);
        survey.vote("C");
        vm.stopPrank();

         vm.startPrank(admin);
        survey.registerVoter("Olivia", 65);
        survey.vote("B");
        vm.stopPrank();

        (uint256 opt1, uint256 opt2, uint256 opt3) = survey.viewResults();
        assertEq(opt1, 1);
        assertEq(opt2, 2);
        assertEq(opt3, 1);
    }

}
