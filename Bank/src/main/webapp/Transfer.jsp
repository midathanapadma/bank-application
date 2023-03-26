<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
double Account=Double.parseDouble(request.getParameter("ano"));
String Name=request.getParameter("uname");
String Password=request.getParameter("psw");
double TargetAccountNo=Double.parseDouble(request.getParameter("tano"));
double WithdrawAmount=Double.parseDouble(request.getParameter("amt"));
double AMOUNT=0.0;
out.print("Welcome!"+Name+"<br>");
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con1=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps=con1.prepareStatement("Select Amount from bank where Name=? and Password=? and Account=?");
	ps.setString(1,Name);
	ps.setString(2,Password);
	ps.setDouble(3,Account);
	ResultSet rs1=ps.executeQuery();
	if(rs1.next())
	{
		AMOUNT=rs1.getDouble(1)-WithdrawAmount;
		out.print(AMOUNT+"<br>");
	}
	Connection con2=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps1=con2.prepareStatement("update bank set AMOUNT=? where NAME=? and PASSWORD=?");
	ps1.setDouble(1,AMOUNT);
	ps1.setString(2,Name);
	ps1.setString(3,Password);
	int i=ps1.executeUpdate();
	out.print(i+"DEBITED AMOUNT updated sucessfully"+"<br>");
	Connection con3=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps2=con3.prepareStatement("Select Amount from bank where Account=?");
	ps2.setDouble(1,TargetAccountNo);
	ResultSet rs2=ps2.executeQuery();
	if(rs2.next())
	{
		AMOUNT=WithdrawAmount+rs2.getDouble(1);
			out.print("Target balance"+AMOUNT+"<br>");
	}
	
	Connection con4=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps3=con4.prepareStatement("update bank set AMOUNT=? where TargetAccountNo=?");
	ps3.setDouble(1,AMOUNT);
	ps3.setDouble(2,TargetAccountNo);
	int j=ps3.executeUpdate();
	out.print(j+"updted Sucessfully");
	con1.close();
	con2.close();
	con3.close();
	con4.close();
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