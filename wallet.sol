pragma solidity >=0.5.13 < 0.7.3;
contract wallet{
    address public owner;
    address public myAddr;
    uint public balances;
    mapping(address => uint) public balanceof;
    mapping(address => uint) public gradelevels;
    constructor() public{
        owner = msg.sender;
    }
    function setaccountlevels(uint acntlevel, address _addr) public onlyOwner{
        gradelevels[_addr] = acntlevel; //this function allows only the owner to set the employee grade with the variable "gradelevels"
    }
    function depositethers() public payable onlyFinteam{
        require((balances + msg.value) >= 0);
        balances += msg.value;  //only Financial team can deposit as many ethers to the depository.
    }
    function withdrawfinteam(uint withdrawAmount) public payable onlyFinteam{
        require(withdrawAmount <= balances);
        myAddr = msg.sender;
        msg.sender.transfer(withdrawAmount);
        balances-=withdrawAmount;   // this function allows only Financial team to withdraw as many ethers as they want.
    }
    function withdrawlevel2(uint withdrawAmount2) public payable onlygrade_2{
        require(withdrawAmount2 <= 40000000000000000000-balanceof[msg.sender]);
        myAddr = msg.sender;
        msg.sender.transfer(withdrawAmount2);
        balanceof[msg.sender]+= withdrawAmount2;
        balances-=withdrawAmount2;  // this function allows only grade2 employees to withdraw only 40 ethers.
    }
    function withdrawlevel3(uint withdrawAmount3) public payable onlygrade_3{
        require(withdrawAmount3 <= 30000000000000000000-balanceof[msg.sender]);
        myAddr = msg.sender;
        msg.sender.transfer(withdrawAmount3);
        balanceof[msg.sender]+= withdrawAmount3;
        balances-=withdrawAmount3;  // this function allows only grade3 employees to withdraw only 30 ethers.
    }
    modifier onlyOwner(){
        require(msg.sender == owner, "only owner has access to this");
        _;    // this modifier gives access only to owner.
    }
    modifier onlyFinteam(){
        require(gradelevels[msg.sender] == 1, "only Financial team has access to this");
        _;    // this modifier gives access only to Financial team.
    }
    modifier onlygrade_2(){
        require(gradelevels[msg.sender] == 2, "only grade 2 has access to this");
        _;    // this modifier gives access only to grade 2 employees.
    }
    modifier onlygrade_3(){
        require(gradelevels[msg.sender] == 3, "only grade3 has access to this");
        _;    // this modifier gives access only to grade 3 employees.
    }
}
