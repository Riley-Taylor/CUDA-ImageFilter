# CUDA-ImageFilter

### IMPORTANT! ###
❗In order to run this project you need a Nvidia GPU or access to a host that will allow you to use theirs. <br>
❗For this assignment I used ASA ( Alabama SuperComputer Authority ). <br>
❗Create a makeFile > Run the makefile > Run the outputted cu file. <br>

### Overview ###
🟪 This application runs by utilizing NVIDIA CudaCores to increase the speed of the runtime. <br>
🟪 On a small scale the increase in speed is small, over large inputs/outputs the increase is larger. <br>
🟪 This program assigns each "pixel" of the image to a core, so it can run in parallel. <br>
🟪 The goal was to simulate aplying a filter to an image. <br>


#### Code Features ####
◻️ The program has a kernel function that allows access to each index. <br>
◻️ As well as place small border around the image, so no memory errors are acheived. <br>
◼️ Allocates memory for the transfer to the GPU. <br>
◼️ Calls the kernel function to perform the task at hand. <br>
◼️ The filter we are applying is a 3x3 matrix full of 9s. <br>
◻️ Transfer the new image back to CPU and prints image on screen.
<br>

___Below is the image!___
<p float="left">
<img src= "https://user-images.githubusercontent.com/96930484/149852504-223d25b0-08dc-4fb7-b690-a25a5206539b.png" width = "900" />
</p>
 
### Future Plans ###
🌟 There are no plans to update this experiment!
