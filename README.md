Insight Data Engineering - Coding Challenge
===========================================================

## My Implementations

For word count, I used both local machine and hadoop mapreduce, because I think this problem is well suited for parallel computing. 

For running median, I only used local machine for the implementation, since the update of the running median depends highly on the previous file lines, and they should happen sequentially.

### To Run using Hadoop Mapreduce and the Local Machine

I used Cloudera CDH 4.1.1, which is a VM used in a similar Udacity training course. This VM has already installed all of the necessary parts. 

	*	Use Virtualbox to load the VM provided, since Github doesn't allow files larger than 100Mb, see details for instructions: https://docs.google.com/document/d/1v0zGBZ6EHap-Smsr3x3sGGpDW-54m82kDpPKC2M6uiY/edit

	*	Inside the VM, run run.sh script by entering ./run.sh, this would use the normal inputs as the input data.

	*	Inside the VM, to run with large input data, enter ./run_user_inputs.sh, and it will prompt the user which input folder to test, then enter large_inputs

### To Run using Local Machine Only

	*	This can be done with whatever Linux system.

	*	Enter ./run_local_only.sh, this will choose the normal inputs data

	*	Or Enter ./run_local_only_user_inputs.sh, this will allow the user to choose their own input folder.

### Running Median for Multiple Files

	*	All of the bash scripts have implemented this feature. 

	*	It will first append all of the input files in sorted order into a single file

	* 	Then it will run the python code.

All of the output files are saved in the outputs folder.

### Algorithm for Running Median

Create a minHeap and a maxHeap, note that Python's heapq library only supports min heap, so in maxHeap a minus sign needs to be added for each element in order to maintain the invariants.

For the first two elements add smaller one to the maxHeap on the left, and bigger one to the minHeap on the right. Then process stream data one by one,

Step 1: Add next item to one of the heaps

   if next item is smaller than maxHeap root add it to maxHeap,
   else add it to minHeap

Step 2: Balance the heaps (after this step heaps will be either balanced or
   one of them will contain 1 more item)

   if number of elements in one of the heaps is greater than the other by
   more than 1, remove the root element from the one containing more elements and
   add to the other one
Then at any given time you can calculate median like this:

   If the heaps contain equal elements;
     median = (root of maxHeap + root of minHeap)/2
   Else
     median = root of the heap with more elements

### Reference: http://stackoverflow.com/questions/10657503/find-running-median-from-a-stream-of-integers


