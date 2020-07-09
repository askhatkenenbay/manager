<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
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
                <th>время</th>
            </tr>
            <c:forEach items="${order}" var="element">
                <tr>
                    <td>+77${element.phone}</td>
                    <td>${element.address}</td>
                    <td>${element.price}</td>
                    <td>${element.date}</td>
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

    <div class="w3-container w3-card w3-white w3-margin-bottom">
        <form method="GET" action="/" style="padding-top: 15px;">
            <input type="hidden" name="export" value="export">
            <button type="submit">Экспорт</button>
        </form>
    </div>
</body>
</html>