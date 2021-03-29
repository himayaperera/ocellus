const multer = require('multer');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads');
      },
    filename: function (req, file, cb) {
        cb(null, file.originalname);
    }
});
const uploadImg = multer({storage: storage}).single('image');

//import Image model
const Image = require('../models/image');
// newImage function for post image route
// const newImage = (req, res, next) => {
//     res.json({message: "POST new image"}); // dummy function for now
// };
const newImage2 = (req, res, next) => {
    res.json({message: "POST new image2"}); // dummy function for now
};

//GET '/Image'
const getAllImage = (req, res, next) => {
   //check if the Image name already exists in db
    //Image.findOne({name:req.body.name},(data)=>{

        //if Image not in db, add it
        //if(data===null){
            //create a new Image object using the Image model and req.body
            const newImage = new Image({
                name:req.body.name,
                image: req.body.image, // placeholder for now
                description: req.body.description,
                keywords: req.body.keywords,
                origin: req.body.origin,
                brew_time: req.body.brew_time,
                temperature: req.body.temperature,
            })

            // save this object to database
            //newImage.save((err, data)=>{
            //    if(err) return res.json({Error: err});
            //    return res.json(data);
            //})
        //if Image is in db, return a message to inform it exists            
        //}else{
            return res.json(newImage);
        //}
    //})    
};

//POST '/Image'
const newImage = (req, res, next) => {
    //check if the Image name already exists in db
    Image.findOne({name:req.body.name},(data)=>{

        //if Image not in db, add it
        if(data===null){
            console.log("new object is creating");
            //create a new Image object using the Image model and req.body
            const newImage = new Image({
                name:req.body.name,
                image: req.file.path // placeholder for now
                //description: req.body.description,
                //keywords: req.body.keywords,
                //origin: req.body.origin,
                //brew_time: req.body.brew_time,
                //temperature: req.body.temperature,
            })

            // save this object to database
            newImage.save((err, data)=>{
                if(err) return res.json({Error: err});
                //console.log("saved");
               return res.json(data);
               
            })
        //if Image is in db, return a message to inform it exists            
        }else{
            //console.log("not saved");
            return res.json(newImage);
            
        }
    }) 
  }

//DELETE '/Image'
const deleImagellImage = (req, res, next) => {
    res.json({message: "DELETE all Image"});
};

//GET '/Image/:name'
const getOneImage = (req, res, next) => {
    res.json({message: "GET 1 Image"});
};

//POST '/Image/:name'
const newComment = (req, res, next) => {
    res.json({message: "POST 1 Image comment"});
};

//DELETE '/Image/:name'
const deleteOneImage = (req, res, next) => {
    res.json({message: "DELETE 1 Image"});
};


module.exports = {newImage,newImage2,getAllImage, 
    newImage,
    deleImagellImage,
    getOneImage,
    newComment,
    deleteOneImage,uploadImg};