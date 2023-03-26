<%@ page import="java.sql.*" %>
<%  
long AccountNumber=Long.parseLong(request.getParameter("ano"));
String Name=request.getParameter("uname");
String Password=request.getParameter("psw");
String Conform_password=request.getParameter("cpsw");
double Amount=Double.parseDouble(request.getParameter("amt"));
String Address=request.getParameter("addr");
Long MobileNo=Long.parseLong(request.getParameter("mno"));
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","padma","welcome");
    
    PreparedStatement ps=con.prepareStatement("insert into bank values (?,?,?,?,?,?)");
    ps.setLong(1,AccountNumber);
    ps.setString(2,Name);
    ps.setString(3,Password);
    ps.setDouble(4,Amount);
    ps.setString(5,Address);
    ps.setLong(6,MobileNo);
    int i=ps.executeUpdate();if(Password.equals(Conform_password))
	{
    out.print("new record inserted successfully...");
    }
  else
    {
    	out.print("insert valid password");
    }

    con.close();
}
catch(Exception ex)
{
	out.print(ex);
}
%>
