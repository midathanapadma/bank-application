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
long Account=Long.parseLong(request.getParameter("ano"));
String Name=request.getParameter("uname");
String Password=request.getParameter("psw");
double Amount=Double.parseDouble(request.getParameter("amt"));
double a=0;
double temp=0;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
    PreparedStatement ps=con.prepareStatement("select Amount from bank  where Account=? and Name=? and Password=?");
    ps.setLong(1,Account);
    ps.setString(2,Name);
    ps.setString(3,Password);
    ResultSet rs=ps.executeQuery();
    if(rs.next())
    {
    	 a=rs.getDouble(1)+Amount;
    	 temp=rs.getDouble(1);
    	PreparedStatement ps1=con.prepareStatement("update bank set Amount=? where Account=?");
    	ps1.setDouble(1,Amount);
    	ps1.setLong(2,Account);
    	int i=ps1.executeUpdate();
    	if(i==1)
    	{
    		out.print("Current balance="+Amount);
    		out.print("Deposited amount="+a+"<br>");
    		out.print(" balance="+temp);
    		
    		
    	}
    	else
    	{
    		out.print("Amount not deposited");
    	}
    }
    con.close();
}
catch(Exception ex)
{
	out.print(ex);
}
%>
</body>
</html>