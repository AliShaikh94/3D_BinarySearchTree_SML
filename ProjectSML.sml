datatype BTree =
                 Empty 
            |    Node of int * BTree * BTree * BTree;

fun Reverse nil = 
        nil
|   Reverse (first::rest) =   
        Reverse rest @ [first];

val seed =
    let
        val m=Date.minute(Date.fromTimeLocal(Time.now()))
        val s=Date.second(Date.fromTimeLocal(Time.now()))
    in
        Random.rand(m,s)
    end;

fun GetRandInt(n)=Random.randRange(1,n) seed;

fun PrintFullPath currentPath =(
        print("(");
        let 
            val path = Reverse currentPath
                        
        in
            print(Int.toString (hd path));
            map (fn x => print(", " ^ Int.toString x)) (tl path)
        end;
        print(") ")

    )


fun AddNode nil currentPath show Empty =(
        Empty
    )
|   AddNode dimVector currentPath show Empty =( 
        let 
            val currentDim = (hd dimVector);
            val remainingDim = (tl dimVector);
            val newPath = currentDim::currentPath;
        in
            if show then
                (
                    (*print("\n");*)
                    PrintFullPath newPath;
                    print(" created \n")
                )
                else ();
            Node(currentDim, Empty, Empty, (AddNode remainingDim newPath show Empty))
        end
    )
|   AddNode dimVector currentPath show (Node(value, left, right, down)) =(
        let 
            val currentDim = hd dimVector;

            val remainingDim = tl dimVector;
            val newPath = value::currentPath;
            val newSidePath = case currentPath of
                                  _::c => c |
                                  nil => []
        in
            (*print("Dimention vector: ");*)
            (*PrintFullPath dimVector;*)
            if show then
            (
                PrintFullPath newPath;
                print("\n")

            )
            else ();

            if currentDim = value 
                then Node(value, left, right, (AddNode remainingDim newPath show down)) 
            else if currentDim < value 
                then Node(value, (AddNode dimVector newSidePath show left), right, down)
            else 
                Node(value, left, (AddNode dimVector newSidePath show right), down)
        end
    );


fun DeleteNode nil currentPath show Empty =(
        print("Nice try, but that wasn't even real.\n");
        Empty
    )
|   DeleteNode dimVector currentPath show Empty =( 
        print("Nice try, but that wasn't even real.\n");
        Empty
    )
|   DeleteNode dimVector currentPath show (Node(value, left, right, down)) =(
        let 
            val currentDim = hd dimVector;

            val remainingDim = tl dimVector;
            val newPath = value::currentPath;
            val newSidePath = case currentPath of
                                  _::c => c |
                                  nil => []
        in
            if null remainingDim 
                then (Node(value, left, right, Node(0, Empty, Empty, Empty)))
            else if currentDim = value 
                then Node(value, left, right, (DeleteNode remainingDim newPath show down)) 
            else if currentDim < value 
                then Node(value, (DeleteNode dimVector newSidePath show left), right, down)
            else 
                Node(value, left, (DeleteNode dimVector newSidePath show right), down)
        end
    );


fun SearchForNode nil currentPath Empty =(
        print(" FOUND\n")
    )

|   SearchForNode dimVector currentPath Empty =(
        let
            val currentDim = hd dimVector;
            val newPath = currentDim::currentPath
        in
            PrintFullPath newPath;
            print(" NOT FOUND\n")
        end
    )
|   SearchForNode dimVector currentPath (Node(value, left, right, down)) =(
        print("\n");
        let
            val currentDim = hd dimVector;
            val remainingDim = tl dimVector;
            val newPath = value::currentPath;
            val newSidePath = case currentPath of
                      _::c => c |
                      nil => []
        in
            PrintFullPath newPath;
            if currentDim = value 
                then SearchForNode remainingDim newPath down
            else if currentDim < value 
                then SearchForNode dimVector newSidePath left
            else 
                SearchForNode dimVector newSidePath right
        end
    );


fun PrintTree currentPath Empty=() 
|   PrintTree currentPath (Node(value, left, right, down))  =(
        PrintTree currentPath left;
        
        if down = Empty then
            PrintFullPath (value::currentPath) 
        else
            PrintTree (value::currentPath) down;
        
        PrintTree currentPath right
        
    );

fun GENERATE(node : BTree, num : int) =
        if num > 0 then
            GENERATE((AddNode [GetRandInt(50), GetRandInt(50), GetRandInt(50)] [] true node), num - 1)
        else
            node;
print("\n");
val mainTree = GENERATE(Empty, 10);
(*val mainTree = Empty;*)
fun ADD oneD twoD threeD bTree = (AddNode [oneD, twoD, threeD] [] true bTree);
fun DELETE dimList bTree = (DeleteNode dimList [] true bTree);
fun PRINT bTree = PrintTree [] bTree;
fun SEARCH oneD twoD threeD bTree= (SearchForNode [oneD, twoD, threeD] [] bTree);