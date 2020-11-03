<%@ page import="helpfulClasses.Point" %><%--
  Created by IntelliJ IDEA.
  User: Sasha
  Date: 31.10.2020
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>My strange lab</title>
    <link rel="icon" type="image/png" href="images/yes_boy.png">
    <link rel="stylesheet" href="Styles/lab_1_styles.css">
    <link rel="stylesheet" href="Styles/style.css">
    <link rel="stylesheet" href="Styles/animations.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

</head>
<body>
<%
    double r;
    int x;
    double y;
    String answer = "Данные оказались невалидными";
    Point currentPoint = (Point) request.getAttribute("currentPoint");
    if (currentPoint != null) {
        r = Double.parseDouble(request.getParameter("R"));
        x = Integer.parseInt(request.getParameter("coordinateX"));
        y = Double.parseDouble(request.getParameter("coordinateY"));
        if (currentPoint.isResult()) answer = "Точка находится в данной области";
        else answer = "Точка находится вне данной области";
    } else {
        r = 0;
        x = 0;
        y = 0;
    }
    %>
<div id="trailer" class="is_overlay">
    <video id="video" width="100%" height="auto" autoplay loop preload muted>
        <source src=Videos/anime.mp4>
    </video>
</div>
<audio controls autoplay hidden>
    <source id="music" src="Videos/astronomia.mp3">
    <script>
        var audio = document.querySelector("audio");
        audio.volume = 0.05;
    </script>
    <p>Ваш браузер не поддерживает аудио</p>
</audio>
<header class="header">
    <div class="content" style="text-align: left">
        <a href="https://vk.com/cawaiv"><span><img src="images/solo_avatar.gif" width="240" height="120"></span><span>Иванников Александр Романович</span>
            <span>Вариант №3138</span></a>
    </div>
</header>
<div class="container content block">
    <div class="block">
        <a class="linkBack" href="${pageContext.request.contextPath}/control" id="new_request">Нажмите сюда, чтобы сделать новый запрос</a>
    </div>
    <div id="result_form"></div>
    <table border="1" class="resultForm">
        <tr>
            <th>Попал?</th>
            <th>Координата X</th>
            <th>Координата Y</th>
            <th>Радиус</th>
            <th>Время запроса</th>
            <th>Время выполнения</th>
        </tr>
        <tr>
            <% if (currentPoint != null) {%>
            <% if (currentPoint.isResult()) { %>
            <td>Да</td>
            <% } else { %>
            <td>Нет</td>
            <% } %>
            <td><%=currentPoint.getX()%></td>
            <td><%=currentPoint.getY()%></td>
            <td><%=currentPoint.getR()%></td>

            <td><%=currentPoint.getTime()%></td>
            <td><%=currentPoint.getDuration()%></td>
            </tbody>
            <% } else { %>
            <tbody>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tbody>
            <% } %>
        </tr>
    </table>
</div>

</body>

<script type="text/javascript" src="scripts/area_script.js"></script>


</html>
