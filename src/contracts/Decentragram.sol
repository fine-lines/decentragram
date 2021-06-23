pragma solidity ^0.8.6;

contract Decentragram {
    string public name = "Decentragram";

    // Image DataStore
    uint public imageCount = 0;
    mapping(uint => Image) public images;

    struct Image {
        uint id;
        string hash;
        string description;
        uint tipAmount;
        address payable author;
    }

    event ImageCreated(
        uint id,
        string hash,
        string description,
        uint tipAmount,
        address payable author
    );

    event ImageTipped(
        uint id,
        string hash,
        string description,
        uint tipAmount,
        address payable author
    )

    // Create image
    function uploadImage(string memory _imgHash, string memory _description) public {
        // sanity checks
        require(bytes(_imgHash) > 0);

        imageCount = imageCount++;
        images[imageCount] = Image(imageCount, _imgHash, _description, 0, msg.sender);
        // Trigger an event
        emit ImageCreate(imageCount, _imgHash, _description, 0, msg.sender);
    }

    // Tip Images
    function tipImageOwner(uint _id) public payable {
        // sanity checks
        require(_id > 0, && _id <= imageCount);

        Image memory _image = images[_id];
        address payable _author = _image.author;
        address(_author).transfer(msg.value);

        // Increment tip amount
        _image.tipAmount = _image.tipAmount + msg.value;
        // Update image
        images[_id] = _image
        // Trigger tip event
        emit ImageTipped(
            _id,
            _image.hash,
            _image.description,
            _image.tipAmount,
            _image.author)
    }
}
