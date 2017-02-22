# 3D_BinarySearchTree_SML

##About   
3 dimensional k-d tree in SML 

The following methods are provided as easy access to the tree.
All of them(except DELETE) take paramters as follows: "ADD 45 6 7 mainTree". The code is written in a strictly pattern matching/curryied style. 

##Command Examples
###GENERATE
    Will generate a 3DBinode 10 deep to any valid Btree;
###ADD oneD twoD threeD bTree 
    Will add a node(s) at the desired location, givng the full path 
###DELETE dimList bTree 
    Will delete a node(s). Must use following format: "DELETE [45,6,7] mainTree"
###PRINT bTree = PrintTree [] bTree;
    Will print the tree. 
###SEARCH oneD twoD threeD bTree
    Will search the tree to check if item exists, with the full path
###myBTree = ADD/DELETE/SEARCH/GENERATE
    To assign the output of any function, use the above format with the respective parameters
##Variables 
###val mainTree 
    An initially generated tree, with 10 randomly generated items. 
