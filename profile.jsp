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
          <title>RRS - Customer Profile</title>
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
                                                <a href="javascript:void(0)" aria-expanded="true"><i class="ti-dashboard"></i><span>Home</span></a>
                                                <ul class="collapse">
                                                  <li><a href="admin.jsp">Dashboard</a></li>
                                                  <li class="active"><a href="profile.jsp">Customer Profile</a></li>
                                                  <li ><a href="voucher.jsp">Voucher</a></li>
                                                  <li><a href="redeem.jsp">Redeem</a></li>
                                                  <!--<li><a href="index2.jsp">Manage Profile</a></li>-->
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
                                                <li><a href="admin.jsp">Home</a></li>
                                                <li><span>Customer Profile</span></li>
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
                                                    <h4 class="user-name dropdown-toggle" data-toggle="dropdown"><%=resultSet.getString("cust_name") %> <i class="fa fa-angle-down"></i></h4>
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

                                                <!-- Striped table end -->
                                                <!-- Bordered Table start -->
                                                <div class="col-lg-12 mt-5">
                                                <div class="card">
                                                <div class="card-body">
                                                <h4 class="header-title">Customer Information</h4>
                                                <div class="single-table">
                                                <div class="table-responsive">
                                                <table class="table table-bordered text-center">
                                                <thead class="text-uppercase">
                                                <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Password</th>
                                                <th>Contact</th>
                                                <th>Point</th>
                                                <th>Action</th>
                                                </tr>
                                                </thead>
                                                <tbody>

                                                <%
                                                try{
                                                  connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                                                  statement = connection.createStatement();
                                                  String sql ="SELECT * FROM custinfo WHERE type = 'customer'";
                                                  resultSet = statement.executeQuery(sql);
                                                  while(resultSet.next()){
                                                    %>

                                                    <tr>
                                                    <td><%=resultSet.getString("cust_id")%></td>
                                                    <td><%=resultSet.getString("cust_name")%></td>
                                                    <td><%=resultSet.getString("cust_email")%></td>
                                                    <td><%=resultSet.getString("cust_password")%></td>
                                                    <td><%=resultSet.getString("cust_contact")%></td>
                                                    <td><%=resultSet.getString("cust_point")%></td>
                                                    <td>
                                                    <ul class="d-flex justify-content-center">
                                                    <li class="mr-3"><a href="editcustomerprofile.jsp?id=<%=resultSet.getString("cust_id") %>" class="text-secondary"><i class="fa fa-edit"></i></a></li>

                                                    </ul>
                                                    </td>
                                                    </tr>
                                                    <%
                                                  }
                                                  connection.close();
                                                } catch (Exception e) {
                                                  e.printStackTrace();
                                                }
                                                %>

                                                </tr>
                                                </tbody>
                                                </table>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                <%@ include file = "footer.jsp" %>
                                                <%}
                                                %>
