<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
<%@page import="java.sql.*" %>
<%
String Account=request.getParameter("ano");
String Name=request.getParameter("uname");
String Password=request.getParameter("psw");
double DepositAmount=Double.parseDouble(request.getParameter("amt"));
out.print("withdrawalAmount:"+DepositAmount+"<br>");
double AMOUNT=0.0;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con1=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps=con1.prepareStatement("select Amount from bank where Name=? and Password=?");
	ps.setString(1,Name);
	ps.setString(2,Password);
	ResultSet rs1=ps.executeQuery();
	if(rs1.next())
	{
		AMOUNT=rs1.getDouble(1);
		out.print("original Balance:"+AMOUNT+"<br>");
		if(AMOUNT>DepositAmount)
		{
			AMOUNT=DepositAmount-AMOUNT;
			out.print("After withdraw:"+AMOUNT+"<br>");
		}
		else
		{
			out.print("insufficient Balance");
			
		}
	}
	Connection con2=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps1=con2.prepareStatement("update bank set Amount=? where Name=? and Password=?");
	ps1.setDouble(1,AMOUNT);
	ps1.setString(2,Name);
	ps1.setString(3,Password);
	int i=ps1.executeUpdate();
	out.print(i+"Updated Sucessfully");
	con1.close();
	con2.close();
}
catch(Exception ex)
{
	out.println(ex);	
	}
%>
</body>
</html>