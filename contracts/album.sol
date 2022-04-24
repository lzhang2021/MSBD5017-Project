pragma solidity ^0.8.0;

contract album {
    struct Album {
        string albumName;
        string albumCoverHash;
    }

    uint totalAlbums;
    uint[] albumIds;

    mapping(uint => Album) albumsMap;

    constructor() {
        totalAlbums = 0;
    }

    function getTotalAlbums() public view returns(uint) {
        return totalAlbums;
    }

    function getAlbumIds() public view returns(uint[] memory) {
        return albumIds;
    }

    function getAlbumById(uint id) public view returns(Album memory) {
        return albumsMap[id];
    }

    function addAlbum(string memory name, string memory imageHash) public {
        totalAlbums++;
        uint id = totalAlbums;
        
        albumsMap[id].albumName = name;
        albumsMap[id].albumCoverHash = imageHash;
        
        albumIds.push(id);
    }
}