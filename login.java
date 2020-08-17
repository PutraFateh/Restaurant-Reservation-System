package myservlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;

@WebServlet("/login")
public class login extends HttpServlet{

	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException{

		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		//--customer data start--//

		//register data
		String reg_email = request.getParameter("reg_email");
		String reg_pass = request.getParameter("reg_pass");
		String reg_name = request.getParameter("reg_name");
		String reg_contact = request.getParameter("reg_contact");
		String reg_confirm_pass = request.getParameter("reg_confirm_pass");
		String reg_referral = request.getParameter("reg_referral");
		String reg_submit = request.getParameter("reg_submit");

		//login data
		String log_email = request.getParameter("log_email");
		String log_pass = request.getParameter("log_pass");
		String log_submit = request.getParameter("log_submit");

		//check email for forgot password data
		String forgot_email = request.getParameter("forgot_email");
		String forgot_submit = request.getParameter("forgot_submit");

		//forgot reset password data
		String reset_new_pass = request.getParameter("reset_new_pass");
		String reset_confirm_pass = request.getParameter("reset_confirm_pass");
		String reset_id = request.getParameter("reset_id");
		String reset_password_submit = request.getParameter("reset_password_submit");

		//reservation data
		String reserve_userid = request.getParameter("reserve_userid");
		String reserve_title = request.getParameter("reserve_title");
		String reserve_time_session = request.getParameter("reserve_time_session");
		String reserve_time = request.getParameter("reserve_time");
		String reserve_pax = request.getParameter("reserve_pax");
		String reserve_seat = request.getParameter("reserve_seat");
		String reserve_voucher_id = request.getParameter("reserve_voucher_id");
		String reserve_voucher_code = request.getParameter("reserve_voucher_code");
		String reserve_redeem = request.getParameter("reserve_redeem");
		String reserve_submit = request.getParameter("reserve_submit");

		//cancel reservation data
		String cancel_reserve_id = request.getParameter("cancel_reserve_id");
		String cancel_reserve_submit = request.getParameter("cancel_reserve_submit");

		//edit profile data
		String edit_email = request.getParameter("edit_email");
		String edit_name = request.getParameter("edit_name");
		String edit_contact = request.getParameter("edit_contact");
		String edit_id = request.getParameter("edit_id");
		String edit_profile_submit = request.getParameter("edit_profile_submit");

		//change password data
		String new_pass = request.getParameter("new_pass");
		String confirm_new_pass = request.getParameter("confirm_new_pass");
		String new_pass_id = request.getParameter("new_pass_id");
		String change_pass_submit = request.getParameter("change_pass_submit");

		//edit reservation data
		String edit_reserve_session = request.getParameter("edit_reserve_session");
		String edit_reserve_date = request.getParameter("edit_reserve_date");
		String edit_reserve_seat = request.getParameter("edit_reserve_seat");
		String edit_reserve_id = request.getParameter("edit_reserve_id");
		String edit_reserve_submit = request.getParameter("edit_reserve_submit");

		//--customer data end--//

		//--admin data start--//

		//edit customer profile data
		String admin_edit_email = request.getParameter("admin_edit_email");
		String admin_edit_name = request.getParameter("admin_edit_name");
		String admin_edit_password = request.getParameter("admin_edit_password");
		String admin_edit_contact = request.getParameter("admin_edit_contact");
		String admin_edit_point = request.getParameter("admin_edit_point");
		String admin_edit_id = request.getParameter("admin_edit_id");
		String admin_edit_profile_submit = request.getParameter("admin_edit_profile_submit");

		//voucher data
		String voucher_code = request.getParameter("voucher_code");
		String voucher_limit = request.getParameter("voucher_limit");
		String save_submit = request.getParameter("save_submit");

		//delete voucher database
		String cancel_voucher_id = request.getParameter("cancel_voucher_id");
		String cancel_voucher_submit = request.getParameter("cancel_voucher_submit");

		//redeem item
        String redeem_item = request.getParameter("redeem_item");
        String reedem_point1 = request.getParameter("reedem_point1");
        String reedem_id = request.getParameter("reedem_id");
        String delete_redeem_submit = request.getParameter("delete_redeem_submit");
        String delete_redeem_id = request.getParameter("delete_redeem_id");
        String add_item_submit = request.getParameter("add_item_submit");
        String save_item_submit = request.getParameter("save_item_submit");

		//--customer sql start--//

		//register sql start
		if (reg_submit != null){
			if (reg_pass.equals(reg_confirm_pass)){
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT cust_email FROM custinfo WHERE cust_email = '"+reg_email+"'");
					if (rs.next()){
						out.println("<script type=\"text/javascript\">");
						out.println("alert('Email already exist. Please try again.');");
						out.println("location='register.jsp?id="+reg_referral+"';");
						out.println("</script>");
					}
					else {
						stmt.executeUpdate("INSERT INTO custinfo(cust_email, cust_password, cust_name, cust_contact, cust_point, referral, type) VALUES('"+reg_email+"','"+reg_pass+"','"+reg_name+"','"+reg_contact+"','0','"+reg_referral+"','customer')");
						stmt.executeUpdate("UPDATE custinfo SET cust_point = cust_point + 5 WHERE cust_id = '"+reg_referral+"'");
						out.println("<script type=\"text/javascript\">");
						out.println("alert('Successfully registered. You can sign in now.');");
						out.println("location='login.jsp';");
						out.println("</script>");
					}
				}catch(Exception e){
					out.println(e);
				}
			}
			else {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Your password and confirm password not matching. Please try again.');");
				out.println("location='register.jsp?id="+reg_referral+"';");
				out.println("</script>");
			}
		}
		//register sql end

		//login sql start
		else if (log_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM custinfo WHERE cust_email = '"+log_email+"' AND cust_password = '"+log_pass+"'");
				if (rs.next()){
					String check_user = rs.getString("type");
					if (check_user.equals("customer")){
						String userid = rs.getString("cust_id");
						HttpSession session = request.getSession();
						session.setAttribute("userid", userid);
						response.sendRedirect("index3.jsp");
					}
					else if (check_user.equals("admin")){
						String userid = rs.getString("cust_id");
						HttpSession session = request.getSession();
						session.setAttribute("userid", userid);
						response.sendRedirect("admin.jsp");
					}
				}
				else {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Login failed. Please try again.');");
					out.println("location='login.jsp';");
					out.println("</script>");
				}
			}catch(Exception e){
				out.println(e);
			}
		}
		//login sql end

		//check email sql start
		if (forgot_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM custinfo WHERE cust_email = '"+forgot_email+"'");
				if (rs.next()){
					String forgot_id = rs.getString("cust_id");
					out.println("<script type=\"text/javascript\">");
					out.println("location='resetpassword.jsp?id="+forgot_id+"';");
					out.println("</script>");
				}
				else {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Email not exist. Please try again');");
					out.println("location='forgotpassword.jsp';");
					out.println("</script>");
				}
			}catch(Exception e){
				out.println(e);
			}
		}
		//check email sql end

		//reset forgot password
		if (reset_password_submit != null){
			if (reset_new_pass.equals(reset_confirm_pass)){
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
					Statement stmt = conn.createStatement();
					stmt.executeUpdate("UPDATE custinfo SET cust_password = '"+reset_new_pass+"' WHERE cust_id = '"+reset_id+"'");
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Successfully reset password. You can sign in now.');");
					out.println("location='login.jsp';");
					out.println("</script>");
				}catch(Exception e){
					out.println(e);
				}
			}
			else {
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Your password and confirm password not matching. Please try again.');");
				out.println("location='resetpassword.jsp?id="+reset_id+"';");
				out.println("</script>");
			}
		}
		//reset forgot password sql end

		//reservation sql start
		else if (reserve_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM redeem_item WHERE redeem_id = '"+reserve_redeem+"'");
				if (rs.next()){
					String totalpoint = rs.getString("redeem_point");
					stmt.executeUpdate("UPDATE custinfo SET cust_point = cust_point - '"+totalpoint+"' WHERE cust_id = '"+reserve_userid+"'");
				}
				else{
					String totalpoint = "0";
					stmt.executeUpdate("UPDATE custinfo SET cust_point = cust_point - '"+totalpoint+"' WHERE cust_id = '"+reserve_userid+"'");
				}
				stmt.executeUpdate("INSERT INTO reservation(cust_id, reserve_title, reserve_session, reserve_time, reserve_pax, reserve_seat, reserve_status) VALUES('"+reserve_userid+"','"+reserve_title+"','"+reserve_time_session+"','"+reserve_time+"','"+reserve_pax+"','"+reserve_seat+"','Success')");
				if (!reserve_voucher_code.equals("")){
					stmt.executeUpdate("UPDATE voucher SET voucher_limit = voucher_limit - 1 WHERE voucher_id = '"+reserve_voucher_id+"'");
					stmt.executeUpdate("INSERT INTO list_voucher(voucher_code, cust_id) VALUES('"+reserve_voucher_code+"','"+reserve_userid+"')");
				}
				out.println("<script type=\"text/javascript\">");
			    out.println("alert('Your reservation booking successful.');");
			    out.println("location='listreservation.jsp';");
			    out.println("</script>");
			}catch(Exception e){
				out.println(e);
			}
		}
		//register sql end

		//cancel reserve sql start
		else if (cancel_reserve_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("UPDATE reservation SET reserve_status = 'Cancelled' WHERE reserve_id = '"+cancel_reserve_id+"'");
				out.println("<script type=\"text/javascript\">");
			    out.println("alert('Your reservation have been cancelled.');");
			    out.println("location='listreservation.jsp';");
			    out.println("</script>");
			}catch(Exception e){
				out.println(e);
			}
		}
		//cancel reserve sql end

		//edit profile sql start
		else if (edit_profile_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("UPDATE custinfo SET cust_email = '"+edit_email+"', cust_name = '"+edit_name+"', cust_contact = '"+edit_contact+"' WHERE cust_id = '"+edit_id+"'");
				//out.println("edit profile success");
				out.println("<script type=\"text/javascript\">");
			    out.println("alert('Your profile have been updated.');");
			    out.println("location='editprofile.jsp?id="+edit_id+"';");
			    out.println("</script>");
				//PreparedStatement ps = conn.prepareStatement("insert into registration(uname, password) values('"+name+"','"+pass+"')");
				//int x = ps.executeUpdate();
			}catch(Exception e){
				out.println(e);
			}
		}
		//edit profile sql end

		//change new password sql start
		else if (change_pass_submit != null){
			if (new_pass.equals(confirm_new_pass)){
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
					Statement stmt = conn.createStatement();
					stmt.executeUpdate("UPDATE custinfo SET cust_password = '"+new_pass+"' WHERE cust_id = '"+new_pass_id+"'");
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Your password have been updated.');");
					out.println("location='changepassword.jsp';");
					out.println("</script>");
				}catch(Exception e){
					out.println(e);
				}
			}
			else{
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Your new password and confirm new password is not matching. Please try again.');");
				out.println("location='changepassword.jsp';");
				out.println("</script>");
			}
		}
		//change new password sql end

		//edit reservation sql start
		else if (edit_reserve_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM reservation WHERE reserve_session = '"+edit_reserve_session+"' AND reserve_time = '"+edit_reserve_date+"' AND reserve_seat = '"+edit_reserve_seat+"'");
				if (rs.next()){
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Seat already reserve. Please try again.');");
					out.println("location='editreservation.jsp?id="+edit_reserve_id+"';");
					//out.println("location='editreservation.jsp?id='"+edit_reserve_id+"'';");
					out.println("</script>");
				}
				else {
					stmt.executeUpdate("UPDATE reservation SET reserve_session = '"+edit_reserve_session+"', reserve_time = '"+edit_reserve_date+"', reserve_seat = '"+edit_reserve_seat+"' WHERE reserve_id = '"+edit_reserve_id+"'");
					out.println("<script type=\"text/javascript\">");
					out.println("alert('Your reservation have been updated.');");
					out.println("location='listreservation.jsp';");
					out.println("</script>");
				}
			}catch(Exception e){
				out.println(e);
			}
		}
		//edit reservation sql end

		//--customer sql end--//

		//--admin sql start--//

		//admin edit customer profile sql start
		        else if (admin_edit_profile_submit != null){
		            try{
		                Class.forName("com.mysql.jdbc.Driver");
		                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
		                Statement stmt = conn.createStatement();
		                stmt.executeUpdate("UPDATE custinfo SET cust_email = '"+admin_edit_email+"', cust_name = '"+admin_edit_name+"', cust_password = '"+admin_edit_password+"', cust_contact = '"+admin_edit_contact+"', cust_point = '"+admin_edit_point+"' WHERE cust_id = '"+admin_edit_id+"'");
		                out.println("<script type='text/javascript'>");
		                out.println("alert('Customer profile have been updated.');");
		                out.println("location='profile.jsp';");
		                out.println("</script>");
		            }catch(Exception e){
		                out.println(e);
		            }
		        }
		        //admin edit customer profile sql end

		//add voucher sql start
		else if (save_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("INSERT INTO voucher(voucher_code, voucher_limit) VALUES('"+voucher_code+"','"+voucher_limit+"')");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Your voucher have been created.');");
				out.println("location='voucher.jsp';");
				out.println("</script>");
			}catch(Exception e){
				out.println(e);
			}
		}
		//add voucher sql end

		//delete voucher sql start
		else if (cancel_voucher_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("DELETE FROM voucher WHERE voucher_id = '"+cancel_voucher_id+"'");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Your voucher have been cancelled.');");
				out.println("location='voucher.jsp';");
				out.println("</script>");
			}catch(Exception e){
				out.println(e);
			}
		}
		//delete voucher sql end

		//Add redeem item sql start
		else if (save_item_submit != null){
		    try{
		        Class.forName("com.mysql.jdbc.Driver");
		        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
		        Statement stmt = conn.createStatement();
		        stmt.executeUpdate("INSERT INTO redeem_item(redeem_item_name, redeem_point) VALUES('"+redeem_item+"','"+reedem_point1+"')");
		        out.println("<script type='text/javascript'>");
		        out.println("alert('Item has been add.');");
		        out.println("location='redeem.jsp';");
		        out.println("</script>");
		    }catch(Exception e){
		        out.println(e);
		    }
		}
		//Add redeem item sql end

		//delete redeem item sql start
		else if (delete_redeem_submit != null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","");
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("DELETE FROM redeem_item WHERE redeem_id = '"+delete_redeem_id+"'");
				out.println("<script type='text/javascript'>");
				out.println("alert('Item have been removed.');");
				out.println("location='redeem.jsp';");
				out.println("</script>");
			}catch(Exception e){
				out.println(e);
			}
		}
		//delete redeem item sql end

		//--admin sql end--//
	}
}
