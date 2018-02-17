pragma solidity ^0.4.18

import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol'

contract mintItem is ERC721Token {

  function mintItem(address _to, uint256 _tokenId) {
    _mint(_to, _tokenId);
  }

  function _genTokenId(address _to) private returns (unit256) {
    _
    keccak256()
  }
}
