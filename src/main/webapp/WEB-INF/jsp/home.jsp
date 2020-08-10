<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<html>
<head>
    <title>Home</title>
    <link rel="icon" type="image/ico"
          href="https://www.atlassian.design/server/images/iconography/Icon_branches_example_24_2x.png"/>
    <meta charset=utf-8>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
        .doubleList {
            columns: 2;
            -webkit-columns: 2;
            -moz-columns: 2;
        }

    </style>
    <style>
        #customers {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #customers td, #customers th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #customers tr:nth-child(even){background-color: #f2f2f2;}

        #customers tr:hover {background-color: #ddd;}

        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #4CAF50;
            color: white;
        }
    </style>
    <style>
        #week {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #week td, #week th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #week tr:nth-child(even){background-color: #f2f2f2;}

        #week tr:hover {background-color: #ddd;}

        #week th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body class="w3-light-grey" >
    <div class="w3-container w3-card w3-white w3-margin-bottom">
        <form method="GET" action="/" id="getUser" style="padding-top: 15px;">
            +77 <input type="number" placeholder="номер телефона" name="phoneNum">
            <button type="submit"><span>Поиск</span></button>
        </form>
        <c:if test="${not empty info}">
            <h3>Итоговая цена: ${info.totalPrice}</h3>
            <h3>Общий заказ: ${info.totalOrder}</h3>
            <h3>Общая средняя цена заказа: ${info.averageOrder}</h3>
            <c:forEach items="${info.topAddress}" var="element">
                <ul  class="doubleList" style="list-style-type:disc;">
                    <li>Адрес: ${element.address} - Счет: ${element.count}</li>
                </ul>
            </c:forEach>
        </c:if>
    </div>

    <div class="w3-container w3-card w3-white w3-margin-bottom">
        <form method="POST" action="/" id="newUser" style="padding-top: 15px;">
            +77 <input type="number" placeholder="номер телефона" name="phoneNum">
            <input type="number" placeholder="цена заказа" name="price">
            <input type="text" placeholder="адрес" name="address" style="width: 350px;height: 50px;">
            <input type="text" placeholder="комментарий" name="comment" style="width: 350px;height: 50px;">
            <button type="submit">Создать</button>
        </form>
        <h3>${message}</h3>
    </div>

    <div class="w3-container w3-card w3-white w3-margin-bottom">
        <h2>Сегодня</h2>
        <table id="customers">
            <tr>
                <th>номер телефона</th>
                <th>адрес</th>
                <th>цена</th>
                <th>комментарий</th>
                <th>время заказа</th>
                <th>время осталось</th>
            </tr>
            <c:forEach items="${order}" var="element" varStatus="theCount">
                <tr>
                    <td>+77${element.phone}</td>
                    <td>${element.address}</td>
                    <td>${element.price}</td>
                    <td>${element.comment}</td>
                    <c:set var = "string1" value = "${element.date}"/>
                    <c:set var = "string2" value = "${fn:substring(string1, 0, 19)}" />
                    <td id="${theCount.index}-date">${string2}</td>
                    <td><p id="${theCount.index}"></p></td> <!-- left time -->
                </tr>
            </c:forEach>
        </table>
        <br>
        <form method="GET" action="/" style="display: inline-block;">
            <input type="hidden" name="before" value="before">
            <button type="submit">Перед</button>
        </form>
        <form method="GET" action="/" style="display: inline-block;">
            <input type="hidden" name="after" value="after">
            <button type="submit">После</button>
        </form>
    </div>
    <h1>${err}</h1>
    <c:if test="${isOlibek}">
    <div class="w3-container w3-card w3-white w3-margin-bottom">
    <h2>Статистика</h2>
        <form method="GET" action="/" >
            <input type="hidden" name="stat" value="stat">
            <button type="submit">Получить статистику</button>
        </form>
        <form method="GET" action="/" >
            <input type="date" name="bydate" value="bydate">
            <button type="submit">Получить статистику по дате</button>
        </form>
        <c:if test="${not empty bydate}">
            <h2>Результат--> Order: ${bydate.totalOrder} - Price: ${bydate.totalPrice}</h2>
        </c:if>
        <c:if test="${not empty stat}">
            <h2>За все время</h2>
            <h3>Общий заказ: ${stat.totalOrder}  -  Итоговая цена: ${stat.totalPrice}</h3>
            <h2>Наибольшая цена</h2>
            <ul style="list-style-type:disc;">
                <c:forEach items="${stat.priceTotalTop}" var="element">
                    <li>номер телефона:+77${element.phone} - адрес: ${element.value}</li>
                </c:forEach>
            </ul>
            <h2>Наибольшая количество заказов</h2>
            <ul style="list-style-type:disc;">
                <c:forEach items="${stat.orderTotalTop}" var="element">
                    <li>номер телефона:+77${element.phone} - адрес: ${element.value}</li>
                </c:forEach>
            </ul>
            <h2>По дням недели</h2>
            <table id="week">
                <tr>
                    <th>День недели</th>
                    <th>Количество заказов</th>
                    <th>Итоговая Цена</th>
                </tr>
                <tr>
                    <td>Понедельник</td>
                    <td><c:out value="${stat.weekOrder[0]}"/></td>
                    <td><c:out value="${stat.weekPrice[0]}"/></td>
                </tr>
                <tr>
                    <td>Вторник</td>
                    <td><c:out value="${stat.weekOrder[1]}"/></td>
                    <td><c:out value="${stat.weekPrice[1]}"/></td>
                </tr>
                <tr>
                    <td>Среда</td>
                    <td><c:out value="${stat.weekOrder[2]}"/></td>
                    <td><c:out value="${stat.weekPrice[2]}"/></td>
                </tr>
                <tr>
                    <td>Четверг</td>
                    <td><c:out value="${stat.weekOrder[3]}"/></td>
                    <td><c:out value="${stat.weekPrice[3]}"/></td>
                </tr>
                <tr>
                    <td>Пятница</td>
                    <td><c:out value="${stat.weekOrder[4]}"/></td>
                    <td><c:out value="${stat.weekPrice[4]}"/></td>
                </tr>
                <tr>
                    <td>Суббота</td>
                    <td><c:out value="${stat.weekOrder[5]}"/></td>
                    <td><c:out value="${stat.weekPrice[5]}"/></td>
                </tr>
                <tr>
                    <td>Воскресенье</td>
                    <td><c:out value="${stat.weekOrder[6]}"/></td>
                    <td><c:out value="${stat.weekPrice[6]}"/></td>
                </tr>
            </table>
            <br><br>
        </c:if>
    </div>
    </c:if>

    <c:if test="${isOlibek}">
    <div class="w3-container w3-card w3-white w3-margin-bottom">
        <form method="GET" action="/" style="padding-top: 15px;">
            <input type="hidden" name="export" value="export">
            <button type="submit">Экспорт</button>
        </form>
    </div>
    </c:if>

    <p id="demo"></p>

    <script>
        var elementId0 = 0;
        var elementDate0 = document.getElementById(0+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate0 = new Date(elementDate0).getTime() + 5400000;
        // Update the count down every 1 second
        var x0 = setInterval(function() {
            // Get today's date and time
            var now0 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance0 = countDownDate0 - now0;

            // Time calculations for days, hours, minutes and seconds
            var days0 = Math.floor(distance0 / (1000 * 60 * 60 * 24));
            var hours0 = Math.floor((distance0 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes0 = Math.floor((distance0 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds0 = Math.floor((distance0 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId0).innerHTML = days0 + "d " + hours0 + "h "
                + minutes0 + "m " + seconds0 + "s ";

            // If the count down is finished, write some text
            if (distance0 < 0) {
                clearInterval(x0);
                document.getElementById(elementId0).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId = 1;
        var elementDate = document.getElementById(1+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate = new Date(elementDate).getTime() + 5400000;
        // Update the count down every 1 second
        var x = setInterval(function() {
            // Get today's date and time
            var now = new Date().getTime();

            // Find the distance between now and the count down date
            var distance = countDownDate - now;

            // Time calculations for days, hours, minutes and seconds
            var days = Math.floor(distance / (1000 * 60 * 60 * 24));
            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((distance % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId).innerHTML = days + "d " + hours + "h "
                + minutes + "m " + seconds + "s ";

            // If the count down is finished, write some text
            if (distance < 0) {
                clearInterval(x);
                document.getElementById(elementId).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId2 = 2;
        var elementDate2 = document.getElementById(2+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate2 = new Date(elementDate2).getTime() + 5400000;
        // Update the count down every 1 second
        var x2 = setInterval(function() {
            // Get today's date and time
            var now2 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance2 = countDownDate2 - now2;

            // Time calculations for days, hours, minutes and seconds
            var days2 = Math.floor(distance2 / (1000 * 60 * 60 * 24));
            var hours2 = Math.floor((distance2 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes2 = Math.floor((distance2 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds2 = Math.floor((distance2 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId2).innerHTML = days2 + "d " + hours2 + "h "
                + minutes2 + "m " + seconds2 + "s ";

            // If the count down is finished, write some text
            if (distance2 < 0) {
                clearInterval(x2);
                document.getElementById(elementId2).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId3 = 3;
        var elementDate3 = document.getElementById(3+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate3 = new Date(elementDate3).getTime() + 5400000;
        // Update the count down every 1 second
        var x3 = setInterval(function() {
            // Get today's date and time
            var now3 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance3 = countDownDate3 - now3;

            // Time calculations for days, hours, minutes and seconds
            var days3 = Math.floor(distance3 / (1000 * 60 * 60 * 24));
            var hours3 = Math.floor((distance3 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes3 = Math.floor((distance3 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds3 = Math.floor((distance3 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId3).innerHTML = days3 + "d " + hours3 + "h "
                + minutes3 + "m " + seconds3 + "s ";

            // If the count down is finished, write some text
            if (distance3 < 0) {
                clearInterval(x3);
                document.getElementById(elementId3).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId4 = 4;
        var elementDate4 = document.getElementById(4+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate4 = new Date(elementDate4).getTime() + 5400000;
        // Update the count down every 1 second
        var x4 = setInterval(function() {
            // Get today's date and time
            var now4 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance4 = countDownDate4 - now4;

            // Time calculations for days, hours, minutes and seconds
            var days4 = Math.floor(distance4 / (1000 * 60 * 60 * 24));
            var hours4 = Math.floor((distance4 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes4 = Math.floor((distance4 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds4 = Math.floor((distance4 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId4).innerHTML = days4 + "d " + hours4 + "h "
                + minutes4 + "m " + seconds4 + "s ";

            // If the count down is finished, write some text
            if (distance4 < 0) {
                clearInterval(x4);
                document.getElementById(elementId4).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId5 = 5;
        var elementDate5 = document.getElementById(5+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate5 = new Date(elementDate5).getTime() + 5400000;
        // Update the count down every 1 second
        var x5 = setInterval(function() {
            // Get today's date and time
            var now5 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance5 = countDownDate5 - now5;

            // Time calculations for days, hours, minutes and seconds
            var days5 = Math.floor(distance5 / (1000 * 60 * 60 * 24));
            var hours5 = Math.floor((distance5 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes5 = Math.floor((distance5 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds5 = Math.floor((distance5 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId5).innerHTML = days5 + "d " + hours5 + "h "
                + minutes5 + "m " + seconds5 + "s ";

            // If the count down is finished, write some text
            if (distance5 < 0) {
                clearInterval(x5);
                document.getElementById(elementId5).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId6 = 6;
        var elementDate6 = document.getElementById(6+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate6 = new Date(elementDate6).getTime() + 5400000;
        // Update the count down every 1 second
        var x6 = setInterval(function() {
            // Get today's date and time
            var now6 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance6 = countDownDate6 - now6;

            // Time calculations for days, hours, minutes and seconds
            var days6 = Math.floor(distance6 / (1000 * 60 * 60 * 24));
            var hours6 = Math.floor((distance6 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes6 = Math.floor((distance6 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds6 = Math.floor((distance6 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId6).innerHTML = days6 + "d " + hours6 + "h "
                + minutes6 + "m " + seconds6 + "s ";

            // If the count down is finished, write some text
            if (distance6 < 0) {
                clearInterval(x6);
                document.getElementById(elementId6).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId7 = 7;
        var elementDate7 = document.getElementById(7+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate7 = new Date(elementDate7).getTime() + 5400000;
        // Update the count down every 1 second
        var x7 = setInterval(function() {
            // Get today's date and time
            var now7 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance7 = countDownDate7 - now7;

            // Time calculations for days, hours, minutes and seconds
            var days7 = Math.floor(distance7 / (1000 * 60 * 60 * 24));
            var hours7 = Math.floor((distance7 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes7 = Math.floor((distance7 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds7 = Math.floor((distance7 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId7).innerHTML = days7 + "d " + hours7 + "h "
                + minutes7 + "m " + seconds7 + "s ";

            // If the count down is finished, write some text
            if (distance7 < 0) {
                clearInterval(x7);
                document.getElementById(elementId7).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId8 = 8;
        var elementDate8 = document.getElementById(8+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate8 = new Date(elementDate8).getTime() + 5400000;
        // Update the count down every 1 second
        var x8 = setInterval(function() {
            // Get today's date and time
            var now8 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance8 = countDownDate8 - now8;

            // Time calculations for days, hours, minutes and seconds
            var days8 = Math.floor(distance8 / (1000 * 60 * 60 * 24));
            var hours8 = Math.floor((distance8 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes8 = Math.floor((distance8 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds8 = Math.floor((distance8 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId8).innerHTML = days8 + "d " + hours8 + "h "
                + minutes8 + "m " + seconds8 + "s ";

            // If the count down is finished, write some text
            if (distance8 < 0) {
                clearInterval(x8);
                document.getElementById(elementId8).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
    <script>
        var elementId9 = 9;
        var elementDate9 = document.getElementById(9+"-date").innerHTML;
        // Set the date we're counting down to
        var countDownDate9 = new Date(elementDate9).getTime() + 5400000;
        // Update the count down every 1 second
        var x9 = setInterval(function() {
            // Get today's date and time
            var now9 = new Date().getTime();

            // Find the distance between now and the count down date
            var distance9 = countDownDate9 - now9;

            // Time calculations for days, hours, minutes and seconds
            var days9 = Math.floor(distance9 / (1000 * 60 * 60 * 24));
            var hours9 = Math.floor((distance9 % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes9 = Math.floor((distance9 % (1000 * 60 * 60)) / (1000 * 60));
            var seconds9 = Math.floor((distance9 % (1000 * 60)) / 1000);

            // Display the result in the element with id="demo"
            document.getElementById(elementId9).innerHTML = days9 + "d " + hours9 + "h "
                + minutes9 + "m " + seconds9 + "s ";

            // If the count down is finished, write some text
            if (distance9 < 0) {
                clearInterval(x9);
                document.getElementById(elementId9).innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
</body>
</html>