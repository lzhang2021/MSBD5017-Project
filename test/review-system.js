const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Review contract", function () {
    let review;
    let album;
    let hardhatReview;
    let hardhatAlbum;
    let albumName = "firstAlbum";
    let imageHash = "0x123456789";
    let addr1;
    let addr2;
    let addrs;

    beforeEach(async function () {
        [addr1, addr2, ...addrs] = await ethers.getSigners();
        review = await ethers.getContractFactory("review");
        album = await ethers.getContractFactory("album");
    
        hardhatReview = await review.deploy();
        hardhatAlbum = await album.deploy();

        await hardhatAlbum.addAlbum(albumName, imageHash);
    });

    it("Test album abstract", async function () {
        const ids = await hardhatAlbum.getAlbumIds();
        const album = await hardhatAlbum.getAlbumById(ids[0]);
        expect(await hardhatAlbum.getTotalAlbums()).to.equal(ids.length);
        expect(album.albumName).to.equal(albumName);
        expect(album.albumCoverHash).to.equal(imageHash);
    });

    it("Test review abstract", async function () {
        const _star = 5;
        const _review = "test review";

        const [id] = await hardhatAlbum.getAlbumIds();
        await hardhatReview.addReview(id, _star, _review);
        const [review] = await hardhatReview.getRatingListById(id);

        expect(review.ratingScore).to.equal(_star);
        expect(review.reviewContent).to.equal(_review);

        await hardhatReview.connect(addr2).addReview(id, _star, _review);
        const totalCount = await hardhatReview.getTotalRatingCount(id);
        const totalScore = await hardhatReview.getTotalRatingScore(id);

        expect(totalCount).to.equal(2);
        expect(totalScore).to.equal(_star * 2);
    });
});