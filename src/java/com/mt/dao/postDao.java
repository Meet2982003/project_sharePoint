/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mt.dao;

import com.mt.entities.Category;
import java.sql.*;
import java.util.ArrayList;
import com.mt.entities.Post;
import java.util.List;

/**
 *
 * @author MEET
 */
public class postDao {

    Connection con;

    public postDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {
            String q = "select * from categories";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(q);

            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean savePost(Post p) {
        boolean f = false;

        try {
            String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    
    //get all the posts
    public List<Post>getAllPosts()
    {
        List<Post> list=new ArrayList<>();
        //fetching all the posts
        try {
            PreparedStatement p=con.prepareStatement("select * from posts order by pid desc");
            ResultSet set=p.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp date=set.getTimestamp("pDate");
                int catId=set.getInt("catId");
                int userId=set.getInt("userId");
                Post post=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Post> getPostByCatId(int catId)
    {
        List<Post> list=new ArrayList<>();
        //fetching all the posts by category id
         //fetching all the posts
        try {
            PreparedStatement p=con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet set=p.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp date=set.getTimestamp("pDate");
                
                int userId=set.getInt("userId");
                Post post=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public Post getPostByPostId(int postId)
    {
        Post post=null;
        String q="select * from posts where pid=?";
        try{
        PreparedStatement p=this.con.prepareStatement(q);
        p.setInt(1,postId);
        ResultSet set=p.executeQuery();
        if(set.next())
        {
            int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp date=set.getTimestamp("pDate");
                int cid=set.getInt("catId");
                
                int userId=set.getInt("userId");
                post=new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
               
           
            
            
        }
        }catch(Exception e){
            e.printStackTrace();
        }
        return post;
    }
}
