(define (treeScale scale tree)
  (cond ((null? tree) tree)
        ((not (pair? tree)) (* scale tree))
        (else (cons (treeScale scale (car tree))
                    (treeScale scale (cdr tree))))))


(define (treeMerge t1 t2)
        ;base case; merging two empty trees results in an empty list
  (cond ((and (null? t1) (null? t2)) t1)
        ;if T1/2 are empty, bind the non-empty T to R
        ((null? t1) t2)
        ((null? t2) t1)
        ;merge a subtree in T2 with a leaf node in T1
        ((and (not (list? (car t1))) (list? (car t2)))
         (cons (treeScale (car t1) (car t2))
               (treeMerge (cdr t1) (cdr t2))))
        ;merge a subtree in T1 with a leaf node in T2
        ((and (not (list? (car t2))) (list? (car t1)))
         (cons (treeScale (car t2) (car t1))
               (treeMerge (cdr t1) (cdr t2))))
        ;merge two subtrees
        ((and (list? (car t1))(list? (car t2)))
         (cons (treeMerge (car t1) (car t2))
               (treeMerge (cdr t1) (cdr t2))))
        ;merge two leaf nodes
        ((and (not (list? (car t1)))(not (list? (car t2))))
         (cons (* (car t1) (car t2))
               (treeMerge (cdr t1) (cdr t2))))))
