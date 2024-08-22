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
<div class="content">
<div class="tileWrapper">
	<a class="tileRow1" href="${ctxPath}/manager/chargepoints">
		Number of<br>Charge Points
		<span class="base formatNumber">${stats.numChargeBoxes}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/ocppTags">
		Number of<br>OCPP Tags
		<span class="base formatNumber">${stats.numOcppTags}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/users">
		Number of<br>Users
		<span class="base formatNumber">${stats.numUsers}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/reservations">
		Number of<br>Active Reservations
		<span class="base formatNumber">${stats.numReservations}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/transactions">
		Number of<br>Active Transactions
		<span class="base formatNumber">${stats.numTransactions}</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/home/ocppJsonStatus">
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
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/chargepoints">
		Received Heartbeats
		<span class="baseTable">
			<span class="baseRow">
				<span class="baseCell">Today :</span>
				<span class="baseCell formatNumber">${stats.heartbeatToday}</span>
			</span>
			<span class="baseRow">
				<span class="baseCell">Yesterday :</span>
				<span class="baseCell formatNumber">${stats.heartbeatYesterday}</span>
			</span>
			<span class="baseRow">
				<span class="baseCell">Earlier :</span>
				<span class="baseCell formatNumber">${stats.heartbeatEarlier}</span>
			</span>
		</span>
	</a>
	<a class="tileRow1" href="${ctxPath}/manager/home/connectorStatus">
		Connector Status
		<span class="baseTable">
			<c:forEach items="${stats.statusCountMap}" var="it">
				<span class="baseRow">
					<span class="baseCell">${it.key} :</span>
					<span class="baseCell formatNumber">${it.value}</span>
				</span>
			</c:forEach>
		</span>
	</a>
	<table class="res action">
		<thead>
		<tr>
			<th data-sort="string">ChargeBox ID</th>
			<th data-sort="string">Description</th>
			<th data-sort="string">OCPP Protocol</th>
			<th data-sort="date">Last Heartbeat</th>
			<th>
				<form:form action="${ctxPath}/manager/chargepoints/add" method="get">
					<input type="submit" class="blueSubmit" value="Add New">
				</form:form>
			</th>
			<th>Message</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${cpList}" var="cp">
			<tr><td><a href="${ctxPath}/manager/chargepoints/details/${cp.chargeBoxPk}">${cp.chargeBoxId}</a></td>
				<td>${cp.description}</td>
				<td>${cp.ocppProtocol}</td>
				<td data-sort-value="${cp.lastHeartbeatTimestampDT.millis}">${cp.lastHeartbeatTimestamp}</td>
				<td>
					<form:form action="${ctxPath}/manager/chargepoints/delete/${cp.chargeBoxPk}">
						<input type="submit" class="redSubmit" value="Delete">
					</form:form>
				</td>
				<td><button type="button" class="greenView">View</button></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<!-- <table class="res" id="connectorStatusTable">
		<thead>
			<tr>
				<th data-sort="string">ChargeBox ID</th>
				<th data-sort="int">Connector ID</th>
				<th data-sort="date">Date/Time</th>
				<th data-sort="string">Status</th>
				<th data-sort="string">Error Code</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${connectorStatusList}" var="cs">
				<tr>
					<td>
						<a href="${ctxPath}/manager/chargepoints/details/${cs.chargeBoxPk}">${cs.chargeBoxId}</a>
						<c:if test="${cs.jsonAndDisconnected}">
							<a class="tooltip" href="#"><img src="${ctxPath}/static/images/offline-icon.svg" style="height: 1em">
								<span>This JSON charge point is currently disconnected. The status information of its
								connectors might be not up-to-date.</span>
							</a>
						</c:if>
					</td>
					<td>${cs.connectorId}</td>
					<td data-sort-value="${cs.statusTimestamp.millis}">${cs.timeStamp}</td>
					<td><encode:forHtml value="${cs.status}" /></td>
					<td><encode:forHtml value="${cs.errorCode}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table> -->
</div></div>
<%@ include file="00-footer.jsp" %>