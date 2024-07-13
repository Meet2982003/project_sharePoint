<%-- 
    Document   : show_post_page
    Created on : 05-Aug-2023, 10:40:58 pm
    Author     : MEET
--%>
<%@page import="com.mt.entities.User" %>
<%@page import="com.mt.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mt.entities.Post" %>
<%@page import="com.mt.dao.postDao"%>
<%@page import="com.mt.dao.UserDao"%>
<%@page import="com.mt.dao.LikeDao"%>
<%@page import="com.mt.helper.ConnectionProvider"%>
<%@page errorPage="error_page.jsp" %>
<%
User user=(User)session.getAttribute("currentUser");
if(user==null){
    response.sendRedirect("login-page.jsp");
    }
%>
<%
int postId=Integer.parseInt(request.getParameter("post_id"));
postDao d=new postDao(ConnectionProvider.getConnection());
Post p=d.getPostByPostId(postId);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%> || sharepoint by Meet</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 100%, 84% 95%, 62% 98%, 41% 98%, 16% 95%, 0 100%);

            }
           
            .post-title{
                font-weight: 100;
                font-size: 35px;
                font-family: sans-serif;
                color: lightyellow;
            }
            .post-content{
                font-weight: 100;
                font-size: 23px;
                font-family: serif;
                text-align: justify;
                text-justify: inter-word;
                
              
            }
            .post-code{
                 font-weight: 100;
                font-size: 25px;
                font-family: serif;
                text-align: justify;
                text-justify: inter-word;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-style: italic;
                font-weight: bold;
                font-size:20px;
            }
            .row-user
            {
                border: 1px solid #37474f;
                padding-top: 15px;
            }
            body{
                 background: #D1E5F4;
                 
                 
            }
        </style>
    </head>
    <body>

        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <b class="navbar-brand" ><span class="fa fa-rocket"></span>SharePoint</b>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.jsp"><span class="fa fa-home"></span>Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-phone"></span>contact</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-list-alt"></span>Subjects
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Java</a>
                            <a class="dropdown-item" href="#">Advance Java</a>
                            <a class="dropdown-item" href="#">Web development</a>
                            <a class="dropdown-item" href="#">Python</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">More subjects can  be added</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-bolt"></span>Goals</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-pencil-square-o"></span>Do Post</a>

                    </li>


                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle "></span><%=user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out "></span>Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--end of navbar-->

        <!-- main content of the body-->

        <div class="container ">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%= p.getpTitle()%></h4>
                        </div>
                        <div class="card-body"style="background-color:rgba(198, 218, 145, 0.1)" >
                            <img class="card-img-top my-2" src="post_pics/<%=p.getpPic()%>" alt="Card image cap">

                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <%
                                    UserDao Udao=new  UserDao(ConnectionProvider.getConnection());
                                    
                                    
                                    %>
                                    <p class="post-user-info">Posted by <a href="#!"><%=Udao.getUserByUserId(p.getUserId()).getName()%></a></p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%=p.getpDate().toLocaleString()%></p>
                                </div>


                            </div>

                            <p class="post-content"><%=p.getpContent()%></p><br><br>
                            <div class="post-code">
                                <pre><%=p.getpCode()%></pre>
                            </div>

                        </div>
                        <div class="card-footer primary-background">
                            <%
                            
                            LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                            
                            
                            %>
                            <a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>  </a>

                            
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!--end of main content of body-->

        <!--start of profile modal-->



        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel " ><span class="fa fa-rocket"></span>MySpace</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%;max-width: 150px;;" >
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%> </h5>
                            <!--//details-->

                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row"> ID :</th>
                                            <td> <%= user.getId()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row"> Email : </th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on :</th>
                                            <td><%= user.getDateTime().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!<!-- profile edit -->

                            <div id="profile-edit" style="display: none">
                                <h3 class="mt-2">Edit carefully</h3>
                                <form action="editServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td> ID:</td>
                                            <td><%=user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td> NAME:</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td> EMAIL:</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td> PASSWORD:</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td> ABOUT:</td>
                                            <td><textarea rows="4" class="form-control" name="about">
                                                    <%=user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td> New Profile:</td>
                                            <td><input type="file"  class="form-control" name="image">

                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" id="edit-profile-button" class="btn btn-primary">EDIT</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end of profile model-->

        <!--add post model  -->



        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><b>Enter Post Details..</b></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="AddPostServlet" method="post" id="add-post-form">
                            <div class="form-group">
                                <select class="form-control" name="cid">

                                    <option selected disabled>--Select category--</option>
                                    <%
                                        postDao postd = new postDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="text" name="pTitle" placeholder="Enter Post Title" class="form-control" >
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="pContent" placeholder="Enter your content" style="height: 150px;"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="pCode" placeholder="Enter your program(if any)" style="height: 100px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Select pic..</label><br>
                                <input type="file" name="pic">
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">post</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!--end add of post model  -->

        <!-- js -->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="myjs.js" type="text/javascript"></script>
      
        

        <script >
            $(document).ready(function () {
                let editStatus = false;


                $('#edit-profile-button').click(function () {

                    if (editStatus == false) {

                        $('#profile-details').hide();

                        $('#profile-edit').show();
                        editStatus = true;
                        $(this).text("back")
                    } else {
                        $('#profile-details').show();

                        $('#profile-edit').hide();
                        editStatus = false;
                        $(this).text("EDIT")
                    }


                })
            });
        </script>

        <!-- Now add post js -->

        <script>
            $(document).ready(function (e) {
                //asynchronous request through ajex
                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submmited
                    event.preventDefault();
                    console.log("you have clicked on submit..")
                    let form = new FormData(this);

                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //successful request
                            console.log(data);
                            if (data.trim() == 'done')
                            {
                                swal("Good job!", "Your post is saved!", "success").then(function () {
                                    window.location = "profile.jsp";
                                });
                            } else
                            {
                                swal("Error occured", "Something went wrong try again", "error").then(function () {
                                    window.location = "profile.jsp";
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error..
                            swal("Error occured", "Something went wrong try again", "error").then(function () {
                                window.location = "profile.jsp";
                            });
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

    </body>
</html>
