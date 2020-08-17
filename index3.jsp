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
    <title>RRS - Dashboard</title>
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
                            <li class="active">
                                <a href="javascript:void(0)" aria-expanded="true"><i class="ti-home"></i><span>Home</span></a>
                                <ul class="collapse">
                                    <li class="active"><a href="index3.jsp">Dashboard</a></li>
                                    <li><a href="referral.jsp">Referral QR Code</a></li>
                                    <li><a href="editprofile.jsp?id=<%=uid %>">Profile</a></li>
									<li><a href="changepassword.jsp">Change Password</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript:void(0)" aria-expanded="true"><i class="fa fa-table"></i>
                                    <span>Reservation</span></a>
                                <ul class="collapse">
                                    <li><a href="listreservation.jsp">Reservation List</a></li>
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
                                <li><span>Dashboard</span></li>
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
				<div class="sales-report-area mt-5 mb-5">
					<!-- row area start -->
					<div class="row">
						<!-- Live Crypto Price area start -->
						<div class="col-lg-4">
							<div class="card">
								<div class="card-body">
									<h4 class="header-title">Activities</h4>
									<div class="cripto-live mt-5">
										<ul>
											<%
											try{
											connection = DriverManager.getConnection(connectionUrl+database, userid, password);
											statement = connection.createStatement();
											String sql = "SELECT * FROM custinfo WHERE cust_id = " + uid;
											resultSet = statement.executeQuery(sql);
											while(resultSet.next()){
											%>
											<li>
												<div class="icon b">P</div> Points<span><i class="fa fa-arrow-right"></i><%=resultSet.getString("cust_point") %></span></li>
											<%
											}
											connection.close();
											} catch (Exception e) {
											e.printStackTrace();
											}
											%>
											<%
											try{
											connection = DriverManager.getConnection(connectionUrl+database, userid, password);
											statement = connection.createStatement();
											String sql = "SELECT COUNT(cust_id) FROM reservation WHERE cust_id = " + uid;
											resultSet = statement.executeQuery(sql);
											while(resultSet.next()){
											%>
											<li>
												<div class="icon l">R</div> Total Reserve<span><i class="fa fa-arrow-right"></i><%=resultSet.getString(1) %></span></li>
											<%
											}
											connection.close();
											} catch (Exception e) {
											e.printStackTrace();
											}
											%>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- Live Crypto Price area end -->
						<!-- trading history area start -->
						<div class="col-lg-8 mt-sm-30 mt-xs-30">
							<div class="card">
								<div class="card-body">
                                <h4 class="header-title">List of Referral </h4>
                                <div class="single-table">
                                    <div class="table-responsive">
                                        <table class="table table-hover progress-table text-center">
                                            <thead class="text-uppercase">
                                                <tr>
													<th scope="col">No.</th>
                                                    <th scope="col">Name</th>
                                                    <th scope="col">Email</th>
													<th scope="col">Contact No.</th>
                                                </tr>
                                            </thead>
                                            <tbody>
											<%
											try{
											connection = DriverManager.getConnection(connectionUrl+database, userid, password);
											statement = connection.createStatement();
											String sql_redeem_item = "SELECT * FROM custinfo WHERE referral = " + uid;
											resultSet = statement.executeQuery(sql_redeem_item);
											int i = 1;
											while(resultSet.next()){
											%>
                                                <tr>
                                                    <th scope="row"><%=i++ %></th>
                                                    <td><%=resultSet.getString("cust_name") %></td>
                                                    <td><%=resultSet.getString("cust_email") %></td>
													<td><%=resultSet.getString("cust_contact") %></td>
                                                </tr>
											<%
											}
											connection.close();
											} catch (Exception e) {
											e.printStackTrace();
											}
											%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
							</div>
						</div>
						<!-- trading history area end -->
					</div>
					<!-- row area end -->
				</div>
            </div>
        </div>
        <!-- main content area end -->
        <%@ include file = "footer.jsp" %>
<%}
%>
