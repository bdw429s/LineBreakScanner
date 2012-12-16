<cfoutput>

	<form action="#event.buildLink("lineBreakScanner")#">
		<strong>Directory:</strong>
		<input type="text" value="#HTMLEditFormat(event.getValue("dir",""))#" name="dir" id="dir" size="100">
		<button type="submit">Scan!</button><br>
		<em>This can be a full path such as "C:\websites\" or a relative mapping such as "\coldbox\system".</em>
	</form>
	<br>
	<br>
		
	<cfif arrayLen(rc.results)>
		<br>
		<h4>CR Only: #rc.results[1].count#</h4>
		<h4>LF Only: #rc.results[2].count#</h>
		<h4>CRLF Only: #rc.results[3].count#</h4>
		<h4>Mixed: #rc.results[4].count#</h4>
		<br>
		<br>
			
		<cfloop array="#rc.results#" index="thisCategory">
			<cfif thisCategory.count>
				<h1>#thisCategory.title# (#thisCategory.count#)</h1>
				<table border="1">
					<tr>
						<td><b>File Name</b></td>
						<td><b>CR</b></td>
						<td><b>LF</b></td>
						<td><b>CRLF</b></td>
					</tr>
					<cfloop array="#thisCategory.files#" index="file">
						<tr>
							<td><a href="#event.buildLink("lineBreakScanner:main.detail")#?fullPath=#URLEncodedFormat(file.fullPath)#">#file.fullPath#</a></td>
							<td><cfif file.hasCR>X</cfif></td>
							<td><cfif file.hasLF>X</cfif></td>
							<td><cfif file.hasCRLF>X</cfif></td>
						</tr>
					</cfloop>
				</table>
				<br>
				<br>
			</cfif>
		</cfloop>
	</cfif>	
</cfoutput>