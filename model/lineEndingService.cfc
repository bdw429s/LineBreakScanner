component singleton {

	function init() {
	
		// Usefull constants
		tab = chr(9);
		CR = chr(13);
		LF = chr(10);
		CRLF = CR&LF;
		CRMarker = '<span class="CR">CR</span>';
		LFMarker = '<span class="LF">LF</span>';
	}

	function scanFiles(dir) {
	
		local.results = [
			{
				title = 'Carriage Returns Only',
				count = 0,
				files = []
			},
			{
				title = 'Line Feeds Only',
				count = 0,
				files = []
			},
			{
				title = 'Carriage Return/Line Feed Only',
				count = 0,
				files = []
			},
			{
				title = 'Mixed Line Endings',
				count = 0,
				files = []
			}
		];
		
		local.files = directoryList(dir,true,'query');
		for(var i=1; i<=local.files.recordCount; i++) {
		
			if(local.files['type'][i] == 'File' && listFindNoCase('cfm,cfc,js,xml,cfml,txt,css,xsd,sql,prefs,config,properties,log,ini,mxml,htm,html,csv,out',listLast(local.files['name'][i],'.'))) {
				local.fullPath = local.files['directory'][i]&'\'&local.files['name'][i];
				local.file = fileRead(fullPath);
			
				local.hasCRLF = find(CRLF,local.file);
			 	local.file = replace(local.file,CRLF,"__CR____LF__","all");
				local.hasCR = find(CR,local.file);
				local.file = replace(local.file,CR,"__CR__","all");
				local.hasLF = find(LF,local.file);
				local.file = replace(local.file,LF,"__LF__","all");
			
				if(hasCR && !hasLF && !hasCRLF) {
					local.thisCategory = results[1];
				}
				else if( hasLF && !hasCR && !hasCRLF) {
					local.thisCategory = results[2];
				}
				else if( hasCRLF && !hasCR && !hasLF) {
					local.thisCategory = results[3];
				}
				else if( hasCRLF || hasCR || hasLF) {
					local.thisCategory = results[4];
				}
				else {
				continue;
				}
							
				local.thisCategory.count++;
				local.fileInfo = {
					fullPath = fullPath,
					hasCR = hasCR,
					hasLF = hasLF,
					hasCRLF = hasCRLF,
				};
				arrayAppend(thisCategory.files,fileInfo);
			}
		}

		return local.results;

	}

	function getFileDetails(fullPath) {
	
		local.file  = fileRead(fullPath);
		
		local.file = HTMLEditFormat(local.file);
		
	    local.file = replace(local.file," ","&nbsp","all");
	    local.file = replace(local.file,tab,"&nbsp&nbsp&nbsp&nbsp&nbsp","all");
		
	    local.file = replace(local.file,CR,"__CR__","all");
		local.file = replace(local.file,LF,"__LF__","all");
		
		local.file = replace(local.file,"__CR____LF__",CRMarker&LFMarker&CRLF,"all");
		local.file = replace(local.file,"__CR__",CRMarker&CRLF,"all");
		local.file = replace(local.file,"__LF__",LFMarker&CRLF,"all");
		
		return local.file;		
	}
	
}