//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {
    string[] public tokens = ["BTC", "ETH"];
    address[] public players;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeTokens() public {
        string[] storage t = tokens;
        t[0] = "VET";
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function transferAll(address payable to)
        public
        onlyOwner
        returns (bool, bytes memory)
    {
        (bool success, bytes memory returnBytes) = to.call{
            value: this.getBalance()
        }("");
        return (success, returnBytes);
    }

    function start() public {
        players.push(msg.sender);
    }

    function concatenate(string calldata a, string calldata b)
        public
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(a, b));
    }

    receive() external payable {}

    fallback() external payable {}
}
