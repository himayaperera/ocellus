const mongoose = require("mongoose"); //import mongoose

// Image schema
const ImageSchema = new mongoose.Schema({
    name: {type:String, required:true},
    image: String
    //description: String,
    //keywords: String,
    //origin: String,
    //brew_time: Number,
    //temperature: Number,
    //comments: [{ text: String, date: {type:String, default: new Date()} }]
});

const Image = mongoose.model('Image', ImageSchema); //convert to model named Image
module.exports = Image; //export for controller use