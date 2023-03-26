<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*"%>
<%
String Name=request.getParameter("uname");
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps=con.prepareStatement("delete from Account where Name=?");
	ps.setString(1,Name);
	int i=ps.executeUpdate();
	out.println(i+"one record is deleted......");
	con.close();
  }
catch(Exception ex)
{
	out.println(ex);
}
%>
</body>
</html>
</body>
</html>