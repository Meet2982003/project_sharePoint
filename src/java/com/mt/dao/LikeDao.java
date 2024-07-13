/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mt.dao;

import com.mysql.cj.jdbc.PreparedStatementWrapper;
import java.sql.*;

/**
 *
 * @author MEET
 */
public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    //to do like on post
    public boolean insertLike(int pid, int uid) {
        boolean f = false;
        try {
            String q = "insert into likePost(pid,uid)values(?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(q);

            //value setup of pid and uid
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;

    }
    
    //to count like on particuler post
    public int countLikeOnPost(int pid) {
        int count = 0;

        String q = "select count(*) from likePost where pid=?";
        try {
            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1, pid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    //to find by which user like is given
    public boolean isLikedByUser(int pid,int uid) {
        boolean f = false;
        try {
            PreparedStatement pstmt=this.con.prepareStatement("select * from likePost where pid=?  and uid=?");
            
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next())
            {
                f=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    //for dislike   
    public boolean deleteLike(int pid,int uid)
    {
        boolean f= false;
        try {
            PreparedStatement pstmt=this.con.prepareStatement("delete from likePost where pid=? and uid=?");
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
