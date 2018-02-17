pragma solidity ^0.4.18

import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol'

contract mintItem is ERC721Token {

  function mintItem(address _to) external {
    _tokenId = _genTokenId(_to);
    _mint(_to, _tokenId);
  }

  function _genTokenId(address _to) private returns (unit256) {
    randomString = "StringBackwards";
    uint rand = uint(keccak256(randomString));
    return rand;
  }
}
