# CSE 464: MCQCorrector
This repo is a MATLAB implementation of an auto MCQ exam paper correction for this kaggle competition:
https://www.kaggle.com/c/cse-464-mcqcorrector/


## The Algorithm
1. Unrotate the image to make it vertical.

![rot_img](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/rot_img.jpg)

2. Complement dilate and binarize the rotated image.

![comp_bw_img](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/comp_bw_img.jpg)

3. Flood fill the image from the background.

![filled](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/filled.jpg)

4. Complement the filled image and close any horizontal gaps with( rectangular element [1 20])) to get a separation between the questions area and any other areas.

![filled_comp](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/filled_comp.jpg)

5. Extract the largest connected component (which is the questions area).

![questions_area](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/questions_area.jpg)

6. Extract a small image containing the left boundary line from the questions area and binarize it to better localize the left boundary of the questions area.

![bw_vert_edge](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/bw_vert_edge.jpg)

7. Extract a small image containing the top boundary line from the questions area and binarize it to better localize the top boundary of the questions area.

![bw_hor_edge](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/bw_hor_edge.jpg)

8. Use the final coordinates to crop 3 images each containing 15 questions from the questions area.

![3im](https://github.com/AhmedMostafaSoliman/MCQ-Corrector/blob/master/illustration/3im.jpg)

9. The locations of the circles in the cropped images are always the same in all images so we just can directly access the pixel values in all circles and compare them together to mark the paper.
