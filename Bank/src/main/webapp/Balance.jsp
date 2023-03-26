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
String Account=request.getParameter("ano");
String Name=request.getParameter("uname");
String Password=request.getParameter("psw");
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
	PreparedStatement ps=con.prepareStatement("select*from bank where  Account=?,Name=? and Password=?");
    ps.setString(1,Account);
	ps.setString(2,Name);
	ps.setString(3,Password);
	ResultSet rs=ps.executeQuery();
	ResultSetMetaData rss=rs.getMetaData();
	int n=rss.getColumnCount();
	out.print("<html><body><table border='2'>");
	for(int i=1;i<=n;i++) {
		out.print("<td><font color=blue size=3>"+"<br>"+rss.getColumnName(i));
		}
	out.println("<tr>");
	while(rs.next())
	{
for(int i=1;i<=n;i++){
	out.println("<td><br>"+rs.getString(i));
	}
	out.print("<tr>");
}
	out.println("</table></body></html>");

	con.close();
}
catch(Exception ex){
	out.print(ex);
}
%>
</body>
</html>