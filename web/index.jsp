<%@page import="com.mt.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mt.helper.ConnectionProvider"%>
<%@page import="com.mt.dao.postDao"%>
<%@page import="com.mt.entities.Message" %>
<%@page import="com.mt.entities.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>JSP Page</title>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 100%, 84% 95%, 62% 98%, 41% 98%, 16% 95%, 0 100%);
            }
            body{
                background: #D1E5F4;
            }



        </style>
    </head>
    <body>
        <!-- navbar -->

        <%@include file="normal_navbar.jsp" %>

        <!-- banner -->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background">
                <div class="container">
                    <h4 class="display-4"><b>Welcome to SharePoint</b></h4>

                    <p>This is world of learning.In this page people can upload posts and share their learning on particular topics.There are categories
                        like Java,MySql,Web programming and python.We can add more categories in future.

                    </p> 
                    <p><h2><b>“Be — don't try to become.”</b><h2></p>
                            <a href="register-page.jsp" class="btn btn-outline-light "><span class="fa fa-user-plus"></span>Start here</a>
                            <a href="login-page.jsp" class="btn btn-outline-light "><span class="fa fa-user-circle fa-spin"></span>Login</a>
                            </div>
                            </div>

                            </div>

                            <!-- cards -->
                            <div class="container">

                                <main>
                                    <div class="container ">
                                        <div class="row my-4">
                                            <!--      first column-->
                                            <div class="col-md-4 mt-5">
                                                <!--     categories-->

                                                <a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active">
                                                    All Posts
                                                </a>
                                                <!--  categories-->

                                                <%
                                                    postDao d=new postDao(ConnectionProvider.getConnection());
                                
                                                    ArrayList<Category>list1=d.getAllCategories();
                                                    for(Category cc:list1)
                                                    {
                                                %>
                                                <a href="#" onclick="getPosts(<%=cc.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= cc.getName() %></a>
                                                <%
                                       }
                        
                                                %>


                                            </div>
                                            <!--   second column-->
                                            <div class="col-md-8 mt-3 posts" >
                                                <!-- posts -it should be dynamic -->
                                                <div class="container text-center" id="loader">
                                                    <i class="fa fa-refresh fa-3x fa-spin"></i>
                                                    <h4 class="mt-2">Loading....</h4>
                                                </div>
                                                <div class="container-fluid" id="post-container">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </main>


                            </div>


                            <!-- js -->
                            <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
                            <script src="myjs.js" type="text/javascript"></script>
                            <script>

                                                    function getPosts(catId, temp) {
                                                        $("#loader").show();
                                                        $("#post-container").hide();
                                                        $(".c-link").removeClass('active')
                                                        $.ajax({
                                                            url: "load_posts.jsp",
                                                            data: {cid: catId},
                                                            success: function (data, textStatus, jqXHR) {
                                                                console.log(data);
                                                                $("#loader").hide();

                                                                $("#post-container").show();
                                                                $("#post-container").html(data)
                                                                $(temp).addClass('active')
                                                            }
                                                        })
                                                    }
                                                    $(document).ready(function (e) {
                                                        let allPostRef = $('.c-link')[0]
                                                        getPosts(0, allPostRef)

                                                    });
                            </script>
                            </body>
                            </html>
