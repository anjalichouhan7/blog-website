<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.dao.Likedao"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.entities.Posts"%>
<%@page import="java.util.List"%>

<div class="row">
<%

	User uu=(User)session.getAttribute("currentUser");

	PostDao d=new PostDao(ConnectionProvider.getConnection());

	int cid=Integer.parseInt(request.getParameter("cid"));

	List<Posts> posts=null;
	//fetch all posts
	if(cid==0)
	{
		posts=d.getAllPost();	
	}
	//fetch posts based on categories
	else{
		posts=d.getPostsByCatId(cid);
	}
	
	if(posts.size()==0)
	{
		out.println("<h3 class='display-3 text-center'>no posts in this catgory</h3>");
		return ;
	}
	for(Posts p:posts)
	{
%>
<div class="col-md-6 mt-2">
	<div class="card">
	<img src="blog_pics/<%= p.getpPic() %>" class="card-img-top" alt="pic">
		<div class="card-body">
			<b><%= p.getpTitle()%></b>
			<p><%= p.getpContent() %></p>
			
		</div>
		
		<div class="card-footer primary-background text-center">
		
		<% Likedao ld=new Likedao(ConnectionProvider.getConnection()); %>
			<a href="show_blog_page.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-light btn-sm">Read More</a>
			<a href="#" onclick="doLike(<%=p.getPid() %>,<%= uu.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span></a>
			<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span> 20</span></a>
		</div>
	</div>
</div>
<%
	}
%>
</div>