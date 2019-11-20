function [tree_model] = ii_train_tree(X,Y)
     
    tree_model=fitctree(X,Y);
    
    % show the trained decision tree
    % view(tree_model);
    
end