<%--

    SteVe - SteckdosenVerwaltung - https://github.com/steve-community/steve
    Copyright (C) 2013-2024 SteVe Community Team
    All Rights Reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

--%>
<%@ include file="00-header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
	.tileRow1 {
            display: inline-block;
            width: 200px;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            text-decoration: none;
            color: #333;
            font-family: Arial, sans-serif;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            background-color: #fff;
        }

        .heartbeat-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .baseTable {
            display: flex;
            justify-content: space-around;
            font-size: 14px;
        }

        .baseRow {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .baseCell {
            margin-bottom: 5px;
            font-weight: normal;
            color: #333;
        }

        .formatNumber {
            font-size: 18px;
            font-weight: bold;
            color: #8a3e3e;
        }
</style>
<div class="content" >
<div class="tileWrapper">
	<a class="tileRow1" href="${ctxPath}/manager/chargepoints">
		Number of<br>Charge Points
		<span class="base formatNumber">${stats.numChargeBoxes}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/ocppTags">
		Number of Connected <br>JSON Charge Points
		<span class="base formatNumber">${stats.numOcppTags}</span>
	</a>
	<!-- <a class="tileRow1" href="${ctxPath}/manager/users">
		Number of<br>Users
		<span class="base formatNumber">${stats.numUsers}</span>
	</a> -->
	<a class="tileRow1" href="${ctxPath}/manager/chargepoints">
        <div class="heartbeat-title">Received Heartbeats</div>
        <div class="baseTable">
            <div class="baseRow">
                <span class="baseCell">Today</span>
                <span class="formatNumber">${stats.heartbeatToday}</span>
            </div>
            <div class="baseRow">
                <span class="baseCell">Yesterday</span>
                <span class="formatNumber">${stats.heartbeatYesterday}</span>
            </div>
            <div class="baseRow">
                <span class="baseCell">Earlier</span>
                <span class="formatNumber">${stats.heartbeatEarlier}</span>
            </div>
        </div>
    </a>
	<a class="tileRow1" href="${ctxPath}/manager/reservations">
		Number of<br>Active Reservations
		<span class="base formatNumber">${stats.numReservations}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/transactions">
		Number of<br>Active Transactions
		<span class="base formatNumber">${stats.numTransactions}</span>
	</a>
	<!-- <a class="tileRow1" href="${ctxPath}/manager/dashboard/ocppJsonStatus">
		Number of Connected<br>JSON Charge Points
		<span class="baseTable">
			<span class="baseRow">
				<span class="baseCell">OCPP 1.2 :</span>
				<span class="baseCell formatNumber">${stats.numOcpp12JChargeBoxes}</span>
			</span>
			<span class="baseRow">
				<span class="baseCell">OCPP 1.5 :</span>
				<span class="baseCell formatNumber">${stats.numOcpp15JChargeBoxes}</span>
			</span>
			<span class="baseRow">
				<span class="baseCell">OCPP 1.6 :</span>
				<span class="baseCell formatNumber">${stats.numOcpp16JChargeBoxes}</span>
			</span>
		</span>
	</a> -->
	
	<!-- <a class="tileRow1" href="${ctxPath}/manager/dashboard/connectorStatus">
		Connector Status
		<span class="baseTable">
			<c:forEach items="${stats.statusCountMap}" var="it">
				<span class="baseRow">
					<span class="baseCell">${it.key} :</span>
					<span class="baseCell formatNumber">${it.value}</span>
				</span>
			</c:forEach>
		</span>
	</a> -->
	<br>
</div>
<div>
		<table class="res action" id="partialContent">
			<thead>
			<tr>
				<th data-sort="string">ChargeBox ID</th>
				<th data-sort="string">Description</th>
				<th data-sort="date">Last Heartbeat</th>
				<th data-sort="number">Connector</th>
				<th data-sort="string">Status</th>
				<!-- <th>
					<form:form action="${ctxPath}/manager/chargepoints/add" method="get">
						<input type="submit" class="blueSubmit" value="Add New">
					</form:form>
				</th> -->
				<th>Message</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${cpList}" var="cp">
				<c:set var="cpId" value="${cp.chargeBoxId}"></c:set>
				<tr><td><a href="${ctxPath}/manager/chargepoints/details/${cp.chargeBoxPk}">${cp.chargeBoxId}</a> <i id="cloudIcon" class="fa fa-cloud" style="display:none;"></i></td>
					<td>${cp.description}</td>
					<td data-sort-value="${cp.lastHeartbeatTimestampDT.millis}">${cp.lastHeartbeatTimestamp}</td>
						<c:choose>
							<c:when test="${cp.connectorCount gt 0}">
								<td>${cp.connectorCount}</td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${cp.connectorCount gt 0}">
								<td>Available</td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>
					<td><button type="button" class="greenView" onclick="viewLogResults('${cp.chargeBoxId}')">View</button></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script>
	 function viewLogResults(chargeBoxId) {
        // Construct the URL to fetch logs based on the context path and chargeBoxId
		// alert(chargeBoxId);
        const url = `/log/charger/`+chargeBoxId;
        
        // Open the URL in a new window or tab
        window.open(url, '_blank');
    }

	$(document).ready(function(){
            // Function to refresh partial content
            function refreshPartialContent() {
                $.ajax({
                    url: 'views/dashboard.jsp',  // URL to fetch the content
                    success: function(data) {
						console.log("refreshing...");
                        $('#partialContent').html(data); // Load content into the div
                    },
                    error: function() {
                        console.error('Failed to load content');
                    }
                });
            }

            // Call the function on page load
            // refreshPartialContent();
			// Call this function periodically or when an event occurs
			// checkConnection();
            // Optionally, refresh periodically or on some event
            // setInterval(refreshPartialContent, 1000); // Refresh every 5 seconds
        });

		function checkConnection() {
			const isConnected = false; // Replace with your actual condition check for connection status

			if (isConnected) {
				document.getElementById("cloudIcon").style.display = "inline"; // Show the icon
			} else {
				document.getElementById("cloudIcon").style.display = "none"; // Hide the icon
			}
		}
</script>

<div></div>
	
<%@ include file="00-footer.jsp" %>