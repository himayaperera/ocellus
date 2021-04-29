const express = require('express'); //import express

// 1.
const router  = express.Router(); 
// 2.
const ImageController = require('../controllers/image'); 
// 3.
//router.post('/image', imageController.newImage); 
//router.post('/image2',imageController.newImage2);
router.post('/Image', ImageController.uploadImg /*insert this guy*/ , ImageController.newImage);
router.get('/Image', ImageController.getAllImage);
router.delete('/Image', ImageController.deleImagellImage);

router.get('/Image/:name', ImageController.getOneImage);
router.post('/Image/:name', ImageController.newComment);
router.delete('/Image/:name', ImageController.deleteOneImage);

// 4. 
module.exports = router; // export to use in server.js