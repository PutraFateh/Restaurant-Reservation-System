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
    <title>RRS - List Reservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="assets/images/icon/favicon.ico">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/metisMenu.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/slicknav.min.css">
    <!-- amcharts css -->
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
    <!-- Start datatable css -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.jqueryui.min.css">
    <!-- style css -->
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
                                <li><a href="listreservation.jsp">Reservation</a></li>
                                <li><span>Reservation List</span></li>
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
                    <!-- Progress Table start -->
                    <div class="col-12 mt-5">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">List of Reservation </h4>
                                <div class="single-table">
                                    <div class="table-responsive">
                                        <table class="table table-hover progress-table text-center">
                                            <thead class="text-uppercase">
                                                <tr>
													<th scope="col">No.</th>
                                                    <th scope="col">Title</th>
                                                    <th scope="col">Time Session</th>
                                                    <th scope="col">Time</th>
                                                    <th scope="col">No. of Pax</th>
                                                    <th scope="col">Seat</th>
                                                    <th scope="col">Status</th>
													<th scope="col">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
											<%
											try{
											connection = DriverManager.getConnection(connectionUrl+database, userid, password);
											statement = connection.createStatement();
											String sql_reservation = "SELECT * FROM reservation WHERE cust_id = '"+uid+"' ORDER BY reserve_time DESC"; 
											resultSet = statement.executeQuery(sql_reservation);
											int i = 1;
											while(resultSet.next()){
											%>
                                                <tr>
                                                    <th scope="row"><%=i++ %></th>
                                                    <td><%=resultSet.getString("reserve_title") %></td>
                                                    <td><%=resultSet.getString("reserve_session") %></td>
													<td><%=resultSet.getString("reserve_time") %></td>
													<td><%=resultSet.getString("reserve_pax") %></td>
													<td><%=resultSet.getString("reserve_seat") %></td>
													<%
													if (resultSet.getString("reserve_status").equals("Success")){													
													%>
														<td><span class="status-p bg-success"><%=resultSet.getString("reserve_status") %></span></td>
														<td>
                                                        <ul class="d-flex justify-content-center">
                                                            <li class="mr-3"><a href="editreservation.jsp?id=<%=resultSet.getString("reserve_id") %>" class="text-secondary"><i class="fa fa-edit"></i></a></li>
                                                            <form method="post" action="login">
																<input type="text" name="cancel_reserve_id" value="<%=resultSet.getString("reserve_id")%>" hidden>
																<li><button type="submit" style="padding:0;border:none;background:none;" class="text-danger" name="cancel_reserve_submit" onclick="return confirm('Are you sure want to cancel the reservation?');"><i class="fa fa-minus-square-o"></i></button></li>
															</form>
                                                        </ul>
                                                    </td>
													<%
													} else{
													%>
														<td><span class="status-p" style="background-color:red;"><%=resultSet.getString("reserve_status") %></span></td>
														<td style="display:none;">
                                                        <ul class="d-flex justify-content-center">
                                                            <li class="mr-3"><a href="editreservation.jsp?id=<%=resultSet.getString("reserve_id") %>" class="text-secondary"><i class="fa fa-edit"></i></a></li>
                                                            <form method="post" action="login">
																<input type="text" name="cancel_reserve_id" value="<%=resultSet.getString("reserve_id")%>" hidden>
																<li><button type="submit" style="padding:0;border:none;background:none;" class="text-danger" name="cancel_reserve_submit" onclick="return confirm('Are you sure want to cancel the reservation?');"><i class="fa fa-minus-square-o"></i></button></li>
															</form>
                                                        </ul>
                                                    </td>
													<%
													}
													%>
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
                    <!-- Progress Table end -->
                </div>
            </div>
        </div>
        <!-- main content area end -->
        <%@ include file = "footer.jsp" %>
<%}
%>