<%--
  Created by IntelliJ IDEA.
  User: Sasha
  Date: 31.10.2020
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="helpfulClasses.Point" language="java" %>
<%@ page import="java.util.ArrayList" %>
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
    <% ArrayList<Point> points = (ArrayList<Point>) session.getAttribute("session");
    if (points == null) points = new ArrayList<>();
    %>
    <div>
        <canvas id="zone" width="300" height="300" class="canvas"></canvas>
        <script type="text/javascript">
            let oldPoint = {
            x1: 150,
            y1: 150,
            x1_normal: 0,
            y1_normal: 0,
            radius1: 2,
            color1: 'blue',
            draw1: function () {
                content_canvas.beginPath();
                content_canvas.arc(this.x1, this.y1, this.radius1, 0, Math.PI * 2, true);
                content_canvas.closePath();
                content_canvas.fillStyle = this.color1;
                content_canvas.fill();
            }
        };
            let canvas = document.getElementById("zone");
            let content_canvas;
            if (canvas.getContext("2d"))
                content_canvas = canvas.getContext("2d");
            drawCoordinateGrid(content_canvas);
            drawOldPoints();
            /*Рисуем основную координатную ось*/
            function drawOldPoints() {
                <% for (Point pointed : points) {%>
                oldPoint.x1_normal = Math.round(((<%=pointed.getX()%> + 5)*30  - 150) / 30);
                oldPoint.y1_normal = ((150 - (<%=pointed.getY()%>)*30 ) / 30).toFixed(2);
                oldPoint.x1 = oldPoint.x1_normal * 30 + 150;
                oldPoint.y1 = (-1 * <%=pointed.getY()%>+5)*30 ;
                oldPoint.draw1();
                <% } %>
            }

            function drawCoordinateGrid(context) {

                context.clearRect(0, 0, 300, 300);
                context.fillStyle = 'rgba(67,113,150,0.8)';
                context.fillRect(0, 0, 300, 300);
                context.fillStyle = "#000000";
                context.beginPath();
                context.moveTo(150, 300);
                context.lineTo(150, 10);
                context.stroke();
                context.moveTo(290, 150);
                context.lineTo(0, 150);
                context.closePath();
                context.stroke();
                context.moveTo(285, 156);
                context.lineTo(285, 144);
                context.lineTo(300, 150);
                context.fill();
                context.moveTo(144, 15);
                context.lineTo(156, 15);
                context.lineTo(150, 0);
                context.fill();
                drawOldPoints()


            }

            function drawArea(context) {
                context.clearRect(0, 0, 300, 300);
                context.fillStyle = 'rgba(255,13,0,0.8)';
                context.fillRect(0, 0, 300, 300);
                drawCoordinateGrid(context);
                let R = Number(r.value);
                context.font = "italic " + 12 + "pt Arial Bold";
                let k, add_value;
                if (!isNaN(R) && R > 0) {
                    if (R < 2) {
                        k = 3;
                        add_value = 30;
                    } else {
                        k = 5;
                        add_value = 15;
                    }
                    for (let i = 150 - 30 * R, j = 0; j < k; i += add_value * R, j++) {
                        context.beginPath();
                        context.moveTo(i, 147);
                        context.lineTo(i, 153);
                        context.stroke();
                        context.moveTo(147, i);
                        context.lineTo(153, i);
                        context.stroke();
                        context.closePath();
                        let zero_point = (i - 150) / 30;
                        if (zero_point !== 0) {
                            context.fillText(String((i - 150) / 30), i - 4, 165);
                            context.fillText(String((150 - i) / 30), 162, i + 3);
                        }
                    }
                    context.fillStyle = 'rgba(0,17,243,0.5)';
                    context.fillRect(150 - R / 2 * 30, 150, R / 2 * 30, R * 30);
                    context.beginPath();
                    context.moveTo(150, 150);
                    context.lineTo(150 + R * 30, 150);
                    context.lineTo(150, 150 + R / 2 * 30);
                    context.closePath();
                    context.arc(150, 150, R * 15, 0, -Math.PI / 2, true);
                    context.fill();
                }

            }

            let point = {
                x: 150,
                y: 150,
                x_normal: 0,
                y_normal: 0,
                radius: 2,
                color: 'black',
                draw: function () {
                    content_canvas.beginPath();
                    content_canvas.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
                    content_canvas.closePath();
                    content_canvas.fillStyle = this.color;
                    content_canvas.fill();
                }
            };

            canvas.onmousemove = function (e) {
                console.log(e.offsetX);
                point.x_normal = Math.round((e.offsetX - 150) / 30);
                point.y_normal = ((150 - e.offsetY) / 30).toFixed(2);
                if (point.x_normal > 4) point.x_normal = 4;
                if (point.x_normal < -4) point.x_normal = -4;
                point.x = point.x_normal * 30 + 150;
                if (point.y_normal > 3) {
                    point.y_normal = 3;
                    point.y = 150 - 3 * 30;
                } else point.y = e.offsetY;
                drawArea(content_canvas);
                point.draw();
            };
        </script>
    </div>
    <form name="myForm" class="form" method="GET" id="coordinate_form">
        Введи радиус и координаты в форму
        <div class="selectBlock">
            <select class="text" id="coordinateX" name="coordinateX">
                <option value="-4">-4</option>
                <option value="-3">-3</option>
                <option value="-2">-2</option>
                <option value="-1">-1</option>
                <option value="0">-0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
            Выберите X
        </div>
        <div class="selectBlock">
            <input class="text input" id="coordinateY" name="coordinateY" maxlength="4">
            Введите Y
        </div>
        <div onclick="drawArea(content_canvas)" class="selectBlock">
            <button type="button" id="r_value_1" onclick="setR(1)" class="selectBtn text input">1</button>
            <button type="button" id="r_value_2" onclick="setR(1.5)" class="selectBtn text input">1.5</button>
            <button type="button" id="r_value_3" onclick="setR(2)" class="selectBtn text input">2</button>
            <button type="button" id="r_value_4" onclick="setR(2.5)" class="selectBtn text input">2.5</button>
            <button type="button" id="r_value_5" onclick="setR(3)" class="selectBtn text input">3</button>
            <input type="hidden" id="R" name="R" value="не выбрано">
            Выберите R
        </div>
        <div>
            <span class="selectBlock">
                <input class="text button" id="mySubmit" type="button" name="mySubmit" value="Утвердить">
            </span>
            <span class="selectBlock">
                <input class="text button" id="myClear" type="reset" name="myClear" value="Очистить">
            </span>
        </div>
    </form>
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
        <% for (Point point : points) {%>
        <tr>
                <% if (point.isResult()) { %>
            <td>Да</td>
                <% } else { %>
            <td>Нет</td>
                <% } %>


            <td><%=point.getX()%>
            </td>
            <td><%=point.getY()%>
            </td>
            <td><%=point.getR()%>
            </td>
            <td><%=point.getTime()%>
            </td>
            <td><%=point.getDuration()%>
            </td>
        <tr>
                <% }
                if (points.isEmpty()) { %>
                <% }%>
    </table>
</div>

</body>

<script>
    canvas.onclick = function (e) {
        if (validateR()) {
            document.forms["myForm"].coordinateY.value = point.y_normal;
            document.forms["myForm"].coordinateX.value = point.x_normal;
            if (validation()) {
                document.getElementById("coordinate_form").submit();
            }
        }
    }
</script>


<script type="text/javascript" src="scripts/area_script.js"></script>


</html>
