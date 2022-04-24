pragma solidity ^0.8.0;

contract review {
    struct AlbumDetail {
        uint totalRating;
        uint totalCount;
        Rating[] ratings;
        mapping(address => bool) ratedUserMap;
    }

    struct Rating {
        address userAddress;
        string reviewContent;
        uint ratingScore;
        uint date;
    }

    mapping(uint => AlbumDetail) albumDetailMap;

    function getRatingListById(uint id) public view returns(Rating[] memory) {
        return albumDetailMap[id].ratings;
    }

    function getTotalRatingScore(uint id) public view returns(uint) {
        return albumDetailMap[id].totalRating;
    }

    function getTotalRatingCount(uint id) public view returns(uint) {
        return albumDetailMap[id].totalCount;
    }

    function addReview(uint id, uint _rating, string memory _review) public {
        require(_rating > 0 && _rating <= 5, "Rating score shoud between 1 and 5.");
        require(albumDetailMap[id].ratedUserMap[msg.sender] == false, "You already rated this album.");

        albumDetailMap[id].totalCount += 1;
        albumDetailMap[id].totalRating += _rating;
        albumDetailMap[id].ratedUserMap[msg.sender] = true;
        albumDetailMap[id].ratings.push(Rating(msg.sender, _review, _rating, block.timestamp));
    }
}