pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";

contract mintItem is ERC721Token {

  function mintItem(address _to) external {
    uint _tokenId = _genTokenId(_to);
    _mint(_to, _tokenId);
  }

  function _genTokenId(address _to) private returns (uint256) {
    string storage randomStr = "StringBackwards";
    uint rand = uint(keccak256(randomStr));
    return rand;
  }
}
