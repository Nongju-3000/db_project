<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String jdbcDriver = "jdbc:mariadb://localhost:3306/yonsei_train_corp";
    String dbUser = "root";
    String dbPass = "root";
    String query = "select * from line";
%>
<html>
<head>
    <title>노선 관리 페이지</title>
</head>
<body>
    <%--headquarter를 등록하거나 수정할 수 있습니다.--%>
    <h1>본부 관리 페이지</h1>
    <form action="line_register_insert.jsp" method="post">
        <input type="text" name="name" placeholder="노선 이름">
        <input type="text" name="year" placeholder="노선 개통년도">
        <input type="text" name="length" placeholder="노선 역 수">
        <input type="text" name="hq" placeholder="노선 본부">
        <input type="submit" value="등록">
    </form>
    <hr>
    <table>
        <%
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
        %>
        <thead>
            <tr>
                <th>노선 이름</th>
                <th>노선 개통년도</th>
                <th>노선 역 수</th>
                <th>노선 본부</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("line_name") %></td>
                <td><%= rs.getString("line_builtyear") %></td>
                <td><%= rs.getString("line_length") %></td>
                <td><%= rs.getString("line_hq_id") %></td>
                <td><a href="line_change.jsp<%= request.setAttribute("id", rs.getInt("line_id")) %>">수정</a></td>
                <td><a href="line_del.jsp<%= request.setAttribute("id", rs.getInt("line_id")) %>">삭제</a></td>
            </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
            %>
        </tbody>
    </table>
<%

%>
</body>
</html>
