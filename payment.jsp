<%
//HERE WE GETTING THE ATTRIBUTE DECLARED IN VALIDATE.JSP AND CHECKING IF IT IS NULL, THE USER WILL BE REDIRECTED TO LOGIN PAGE
String uid = (String)session.getAttribute("userid");
if (uid == null)
{
%>
<jsp:forward page="login.jsp"/>

<%
}else
{//IF THE VALUE IN SESSION IS NOT NULL THEN THE IS USER IS VALID
%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "test";
String userid = "root";
String password = "";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;

try{
	connection = DriverManager.getConnection(connectionUrl+database, userid, password);
	statement = connection.createStatement();
	String check_session = request.getParameter("reserve_time_session");
	String check_time = request.getParameter("reserve_time");
	String check_seat = request.getParameter("reserve_seat");
	String check_voucher = request.getParameter("reserve_voucher_code");
	
	String sql_check_seat = "SELECT * FROM reservation WHERE reserve_session = '"+check_session+"' AND reserve_time = '"+check_time+"' AND reserve_seat = '"+check_seat+"'";
	resultSet = statement.executeQuery(sql_check_seat);
	if (resultSet.next()){
		out.println("<script type=\'text/javascript\'>");
		out.println("alert('Seat already reserve. Please try again.');");
		out.println("location='form.jsp';");
		out.println("</script>");
	}
	
	String sql_check_usedvoucher = "SELECT * FROM list_voucher WHERE voucher_code = '"+check_voucher+"' AND cust_id = '"+uid+"'";
	resultSet = statement.executeQuery(sql_check_usedvoucher);
	if (resultSet.next()){
		out.println("<script type=\'text/javascript\'>");
		out.println("alert('You already use this voucher. Please try again.');");
		out.println("location='form.jsp';");
		out.println("</script>");
	}
	
	String sql_check_limitvoucher = "SELECT * FROM voucher WHERE voucher_code = '"+check_voucher+"' AND voucher_limit = '0'";
	resultSet = statement.executeQuery(sql_check_limitvoucher);
	if (resultSet.next()){
		out.println("<script type=\'text/javascript\'>");
		out.println("alert('This voucher reach the limit. Please try again.');");
		out.println("location='form.jsp';");
		out.println("</script>");
	}

	else{
%>

<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>RRS - New Reservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="assets/images/icon/favicon.ico">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/metisMenu.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/slicknav.min.css">
    <!-- amchart css -->
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
    <!-- others css -->
    <link rel="stylesheet" href="assets/css/typography.css">
    <link rel="stylesheet" href="assets/css/default-css.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/responsive.css">
    <!-- modernizr css -->
    <script src="assets/js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body>
    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
    <!-- preloader area start -->
    <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- preloader area end -->
    <!-- page container area start -->
    <div class="page-container">
        <!-- sidebar menu area start -->
        <div class="sidebar-menu">
            <div class="sidebar-header">
                <div class="logo">
                    <h5 style="color:white;">Restaurant Reservation System</h5>
                </div>
            </div>
            <div class="main-menu">
                <div class="menu-inner">
                    <nav>
                        <ul class="metismenu" id="menu">
                            <li>
                                <a href="javascript:void(0)" aria-expanded="true"><i class="ti-home"></i><span>Home</span></a>
                                <ul class="collapse">
                                    <li><a href="index3.jsp">Dashboard</a></li>
                                    <li><a href="referral.jsp">Referral QR Code</a></li>
                                    <li><a href="editprofile.jsp?id=<%=uid %>">Profile</a></li>
									<li><a href="changepassword.jsp">Change Password</a></li>
                                </ul>
                            </li>
                            <li class="active">
                                <a href="javascript:void(0)" aria-expanded="true"><i class="fa fa-table"></i>
                                    <span>Reservation</span></a>
                                <ul class="collapse">
                                    <li><a href="listreservation.jsp">Reservation List</a></li>
                                    <li class="active"><a href="form.jsp">New Reservation</a></li>
                                </ul>
                            </li>
							<li>
                                <a href="javascript:void(0)" aria-expanded="true"><i class="fa fa-paw"></i>
                                    <span>Redeem Items</span></a>
                                <ul class="collapse">
                                    <li><a href="listredeemitem.jsp">List Offers</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <!-- sidebar menu area end -->
        <!-- main content area start -->
        <div class="main-content">
            <!-- page title area start -->
            <div class="page-title-area">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="breadcrumbs-area clearfix">
                            <ul class="breadcrumbs pull-left">
                                <li><a href="listreservation.jsp">Reservation</a></li>
                                <li><span>New Reservation</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-6 clearfix">
                        <div class="user-profile pull-right">
                            <img class="avatar user-thumb" src="assets/images/author/avatar.png" alt="avatar">
							<%
							try{
							connection = DriverManager.getConnection(connectionUrl+database, userid, password);
							statement = connection.createStatement();
							String sql = "SELECT * FROM custinfo WHERE cust_id = " + uid;
							resultSet = statement.executeQuery(sql);
							while(resultSet.next()){
							%>
                            <h4 class="user-name dropdown-toggle" data-toggle="dropdown"><%=resultSet.getString("cust_name") %><i class="fa fa-angle-down"></i></h4>
							<%
							}
							connection.close();
							} catch (Exception e) {
							e.printStackTrace();
							}
							%>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="login.jsp">Log Out</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- page title area end -->
            <div class="main-content-inner">
                <div class="row">
                    <div class="col-lg-6 col-ml-12">
                        <div class="row">
                            <!-- Textual inputs start -->
                            <div class="col-12 mt-5">
                                <div class="card">
                                    <div class="card-body">
										<form method="post" action="login">
											<h4 class="header-title">Payment Details</h4>
											<p class="text-muted font-14 mb-4">Please fill the form to make a payment.</p>
											<div class="form-group">
												<label for="example-time-input" class="col-form-label">Card Number</label>
												<input class="form-control" type="text" required>
											</div>
											<div class="form-row">
                                                <div class="col-md-6 mb-3">
                                                    <label for="validationCustom03">Expiration Date</label>
                                                    <input class="form-control" type="date" required>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <label for="validationCustom05">CV Code</label>
                                                    <input class="form-control" type="text" required>
                                                </div>
                                            </div>
											<%
											try{
											connection = DriverManager.getConnection(connectionUrl+database, userid, password);
											statement = connection.createStatement();
											String voucher_redeem = request.getParameter("reserve_voucher_code");
											String sql_voucher = "SELECT * FROM voucher WHERE voucher_code = '"+voucher_redeem+"'";
											resultSet = statement.executeQuery(sql_voucher);
											if (resultSet.next()){
												String voucher_id = resultSet.getString("voucher_id");
												String voucher_name = resultSet.getString("voucher_code");
											%>
												<p class="text-muted font-14 mb-4">Payment: Free with voucher (<%=voucher_name%>)</p>
												<input type="text" name="reserve_voucher_id" value="<%=voucher_id%>" hidden>
												<input type="text" name="reserve_voucher_code" value="<%=voucher_name%>" hidden>

											<%
											} else{
												String voucher_id = "";
												String voucher_name = "";
											%>
												<p class="text-muted font-14 mb-4">Payment: RM10 <%=voucher_id %> <%=voucher_name%></p>
												<input type="text" name="reserve_voucher_id" value="<%=voucher_id%>" hidden>
												<input type="text" name="reserve_voucher_code" value="<%=voucher_name%>" hidden>

											<%
											}
											connection.close();
											} catch (Exception e) {
											e.printStackTrace();
											}
											%>
											
											<input type="text" name="reserve_userid" value="<%=uid%>" hidden>
											<input type="text" name="reserve_title" value="<%=request.getParameter("reserve_title")%>" hidden>
											<input type="text" name="reserve_time_session" value="<%=request.getParameter("reserve_time_session")%>" hidden>
											<input type="date" name="reserve_time" value="<%=request.getParameter("reserve_time")%>" hidden>
											<input type="text" name="reserve_pax" value="<%=request.getParameter("reserve_pax")%>" hidden>
											<input type="text" name="reserve_seat" value="<%=request.getParameter("reserve_seat")%>" hidden>
											<input type="text" name="reserve_redeem" value="<%=request.getParameter("reserve_redeem")%>" hidden>
											<button type="submit" class="btn btn-primary mt-4 pr-4 pl-4" name="reserve_submit">Submit</button>
										</form>
                                    </div>
                                </div>
                            </div>
                            <!-- Textual inputs end -->
                        </div>
                    </div>
                    <div class="col-lg-6 col-ml-12">
                        <div class="row">
                            <!-- basic form start -->
                            <div class="col-12 mt-5">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="header-title">Reservation Information</h4>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Title: <%=request.getParameter("reserve_title")%></label>
                                        </div>
										<div class="form-group">
                                            <label for="exampleInputEmail1">Time Session: <%=request.getParameter("reserve_time_session")%></label>
                                        </div>
										<div class="form-group">
                                            <label for="exampleInputEmail1">Time: <%=request.getParameter("reserve_time")%></label>
                                        </div>
										<div class="form-group">
                                            <label for="exampleInputEmail1">No. of Pax: <%=request.getParameter("reserve_pax")%></label>
                                        </div>
										<div class="form-group">
                                            <label for="exampleInputEmail1">Seat: <%=request.getParameter("reserve_seat")%></label>
                                        </div>
										<%
										try{
										connection = DriverManager.getConnection(connectionUrl+database, userid, password);
										statement = connection.createStatement();
										String sql_redeem_name = "SELECT * FROM redeem_item WHERE redeem_id = '"+request.getParameter("reserve_redeem")+"'";
										resultSet = statement.executeQuery(sql_redeem_name);
										if(resultSet.next()){
										%>
										<div class="form-group">
                                            <label for="exampleInputEmail1">Redeem item: <%=resultSet.getString("redeem_item_name")%></label>
                                        </div>
										<%
										}
										connection.close();
										} catch (Exception e) {
										e.printStackTrace();
										}
										%>
                                    </div>
                                </div>
                            </div>
                            <!-- basic form end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- main content area end -->
        <%@ include file = "footer.jsp" %>
<%
	}
	connection.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%> 