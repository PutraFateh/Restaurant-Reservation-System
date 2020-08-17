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
%>

<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>RRS - Edit Reservation</title>
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
                                    <li class="active"><a href="listreservation.jsp">Reservation List</a></li>
                                    <li><a href="form.jsp">New Reservation</a></li>
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
                                <li><a href="index3.jsp">Home</a></li>
                                <li><span>Edit Reservation</span></li>
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
										<%
										try{
										connection = DriverManager.getConnection(connectionUrl+database, userid, password);
										statement = connection.createStatement();
										String reserveid = request.getParameter("id");
										String sql_editreservation = "SELECT * FROM reservation WHERE reserve_id = " + reserveid;
										resultSet = statement.executeQuery(sql_editreservation);
										while(resultSet.next()){
										%>
											<h4 class="header-title">Edit Reservation</h4>
											<p class="text-muted font-14 mb-4">Please fill the form to make a reservation.</p>
											<div class="form-group">
												<label for="example-text-input" class="col-form-label">Title</label>
												<input class="form-control" type="text" name="edit_reserve_title" value="<%=resultSet.getString("reserve_title") %>" disabled>
											</div>
											<div class="form-group">
												<label class="col-form-label">Time Session</label>
												<select class="form-control" name="edit_reserve_session">
													<option value="Session A : 12PM - 4PM" <% if (resultSet.getString("reserve_session").equals("Session A : 12PM - 4PM")){%> selected <%} %>>Session A : 12PM - 4PM</option>
													<option value="Sesionn B : 5PM - 11PM" <% if (resultSet.getString("reserve_session").equals("Sesionn B : 5PM - 11PM")){%> selected <%} %>>Sesionn B : 5PM - 11PM</option>
												</select>
											</div>
											<div class="form-group">
												<label for="example-time-input" class="col-form-label">Date</label>
												<input class="form-control" type="date" name="edit_reserve_date" value="<%=resultSet.getString("reserve_time") %>">
											</div>
											<div class="form-group">
												<label class="col-form-label">Seat</label>
												<select class="form-control" name="edit_reserve_seat">
													<option value="1" <% if (resultSet.getString("reserve_seat").equals("1")){%> selected <%} %>>1</option>
													<option value="2" <% if (resultSet.getString("reserve_seat").equals("2")){%> selected <%} %>>2</option>
													<option value="3" <% if (resultSet.getString("reserve_seat").equals("3")){%> selected <%} %>>3</option>
													<option value="4" <% if (resultSet.getString("reserve_seat").equals("4")){%> selected <%} %>>4</option>
													<option value="5" <% if (resultSet.getString("reserve_seat").equals("5")){%> selected <%} %>>5</option>
													<option value="6" <% if (resultSet.getString("reserve_seat").equals("6")){%> selected <%} %>>6</option>
													<option value="7" <% if (resultSet.getString("reserve_seat").equals("7")){%> selected <%} %>>7</option>
													<option value="8" <% if (resultSet.getString("reserve_seat").equals("8")){%> selected <%} %>>8</option>
													<option value="9" <% if (resultSet.getString("reserve_seat").equals("9")){%> selected <%} %>>9</option>
													<option value="10" <% if (resultSet.getString("reserve_seat").equals("10")){%> selected <%} %>>10</option>
													<option value="11" <% if (resultSet.getString("reserve_seat").equals("11")){%> selected <%} %>>11</option>
													<option value="12" <% if (resultSet.getString("reserve_seat").equals("12")){%> selected <%} %>>12</option>
													<option value="13" <% if (resultSet.getString("reserve_seat").equals("13")){%> selected <%} %>>13</option>
													<option value="14" <% if (resultSet.getString("reserve_seat").equals("14")){%> selected <%} %>>14</option>
													<option value="15" <% if (resultSet.getString("reserve_seat").equals("15")){%> selected <%} %>>15</option>
													<option value="16" <% if (resultSet.getString("reserve_seat").equals("16")){%> selected <%} %>>16</option>
													<option value="17" <% if (resultSet.getString("reserve_seat").equals("17")){%> selected <%} %>>17</option>
												</select>
											</div>
											<input type="text" name="edit_reserve_id" value="<%=resultSet.getString("reserve_id")%>" hidden>
											<button type="submit" class="btn btn-primary mt-4 pr-4 pl-4" name="edit_reserve_submit">Submit</button>
										<%
										}
										connection.close();
										} catch (Exception e) {
										e.printStackTrace();
										}
										%>
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
                                        <h4 class="header-title"><center>Seat Placement</center></h4>
                                        <img src="assets/images/bg/lol.JPG">
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
<%}
%>