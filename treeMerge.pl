%treeScale(V,T,R) scales all leaves in the tree T by a value V and binds the
%result to R
%(Required for treeMerge)

treeScale(_,[],[]).
treeScale(V,[H|T],[X|R]):-
  is_list(H),%if the current node is a list, recurse on head and tail
  treeScale(V,H,X),
  treeScale(V,T,R).

treeScale(V,[H|T],[X|R]):-
  not(is_list(H)),%if the current node is an atom, scale the leaf
  X is H*V,       %and recurse on the tail
  treeScale(V,T,R).

%treeMerge(T1,T2,R) binds the result of merging T1 and T2 to R
/*
MERGING CRITERIA

Merging two trees is done by recursing through their structure and multiplying
their subtrees
The root of T1 is merged with the root of T2
The first child is merged with the first child
Second with second... etc, etc, etc, ...
Merging two leaf nodes is done by multiplying their values
(you may assume they are numbers).
Merging a leaf node with a subtree is done by scaling the subtree by the value
of the leaf.
Merging a subtree with an empty tree, is simply the non-empty subtree.

*/
treeMerge([],[],[]).%base case; merging two empty trees results in an empty list
treeMerge(R,[],R).%if T1/2 are empty, bind the non-empty T to R
treeMerge([],R,R).

%Merge a leaf node in T1 with subtree in T2
treeMerge([H1|T1],[H2|T2],[X|R]):-
  not(is_list(H1)),
  is_list(H2),
  treeMerge(T1,T2,R),
  treeScale(H1,H2,X).

%merge a subtree in T1 with a leaf node in T2
treeMerge([H1|T1],[H2|T2],[X|R]):-
  is_list(H1),
  not(is_list(H2)),
  treeMerge(T1,T2,R),
  treeScale(H2,H1,X).

%merge two subtrees
treeMerge([H1|T1],[H2|T2],[X|R]):-
  is_list(H1),
  is_list(H2),
  treeMerge(H1,H2,X),
  treeMerge(T1,T2,R).

%merge two leaf nodes
treeMerge([H1|T1],[H2|T2],[X|R]):-
  not(is_list(H1)),
  not(is_list(H2)),
  X is H1*H2,
  treeMerge(T1,T2,R).
