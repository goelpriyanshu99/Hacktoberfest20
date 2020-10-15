public class B_Tree{
	private TreeNode root;
	B_Tree(){
		root = null;
	}
	TreeNode getRoot(){
		return root;
	}
	void PostOrderTraversal(TreeNode root){
		if(root!=null){
			PostOrderTraversal(root.left);
			PostOrderTraversal(root.right);
			System.out.print(root.getData()+" ");
		}
	}
	void PreOrderTraversal(TreeNode root){
		if(root!=null){
			System.out.print(root.getData()+" ");
			PreOrderTraversal(root.left);
			PreOrderTraversal(root.right);
		}
	}
	void InOrderTraversal(TreeNode root){
		if(root!=null){
			InOrderTraversal(root.left);
			System.out.print(root.getData()+" ");
			InOrderTraversal(root.right);
		}
	}

	void LevelOrderTraversal(TreeNode root){
		Queue q = new Queue();
		q.add(root);
		while(!q.isEmpty()){
			TreeNode z = q.top.getTreeNode();
			System.out.print(z.getData()+" ");
			if(z.left!=null)
				q.add(z.left);
			if(z.right!=null)
				q.add(z.right);
			q.delete();
		}
		System.out.println();
	}

	void delete(int y){
		
	}

	TreeNode insert(TreeNode root,int n){
		if(root == null)
			return new TreeNode(n);
		else{
			if(root.getData() < n)
				root.right = insert(root.right,n);
			else
				root.left = insert(root.left,n);
		}
		return root;
	}
	void insert(int y){
		root = insert(root,y);
	}
	int countNodes(TreeNode root){
		if(root == null)
			return 0;
		else{
			int c = 1;
			c += countNodes(root.left);
			c += countNodes(root.right);
			return c;
		}
	}
}