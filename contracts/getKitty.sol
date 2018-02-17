pragma solidity ^0.4.18

contract KittyInterface {

  function getKitty(uint256 _id) external view returns (
                                                        bool isGestating,
                                                        bool isReady,
                                                        uint256 cooldownIndex,
                                                        uint256 nextActionAt,
                                                        uint256 siringWithId,
                                                        uint256 birthTime,
                                                        uint256 matronId,
                                                        uint256 sireId,
                                                        uint256 generation,
                                                        uint256 genes
                                                        );

  function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);
  }

  function getKittyDna(uint _zombieId, uint _kittyId) returns uint public{
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    return kittyDna;
  }
}
