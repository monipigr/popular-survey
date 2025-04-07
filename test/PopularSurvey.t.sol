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
        string memory option_ = "A";

        vm.startPrank(user1);
        survey.vote(option_);

        //Cómo compruebo que se suma correctamente?? 
        // assertEq(option_, survey.options.counterOption1, "Voto incorrecto"); 
        
        vm.stopPrank();
    }

    // Testea que el usuario no puede votar si no se ha registrado previamente 
    
    
    // Testea que el usuario no puede votar si no es adulto


    // Testea que un usuario no puede votar dos veces


    // Testea que el usuario no puede votar una opción inválida


    // Testea que el contador de opciones funciona correctamente


}
