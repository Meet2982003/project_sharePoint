<%@page import="com.mt.entities.User" %>
<%@page import="com.mt.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mt.entities.Post" %>
<%@page import="com.mt.dao.postDao"%>
<%@page import="com.mt.dao.UserDao"%>
<%@page import="com.mt.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mt.helper.ConnectionProvider"%>

<style>
    .card-body{
        display: none;
    }
</style>
<div class="row">

    <%
        
     User user=(User)session.getAttribute("currentUser");
        
        Thread.sleep(1000);
        postDao d = new postDao(ConnectionProvider.getConnection());
        
        int cid = Integer.parseInt(request.getParameter("cid"));
       
      
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        
        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
            return;
        }
        
        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-4">
        <div class="card">
            <b><center><%= p.getpTitle()%></center></b>
            <img class="card-img-top" src="post_pics/<%= p.getpPic()%>" alt="image">

            <div class="card-body">

                <p><%= p.getpContent()%></p>

            </div>
            <div class="card-footer primary-background text-center">
                <%
                LikeDao ld= new LikeDao(ConnectionProvider.getConnection());
               
                %>

                <a href="#!"  class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"></span> <%=ld.countLikeOnPost(p.getPid())%> </a>

                <a href="show_post_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-outline-light btn-sm">Read More...</a>

            </div>

        </div>


    </div>


    <%
        }
        

    %>

</div>