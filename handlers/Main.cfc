component{
	property name="lineEndingService" inject="lineEndingService@lineBreakScanner";
	
	function index(event,rc,prc){
		rc.results = [];
		if(event.valueExists('dir') && len(rc.dir)) {
			rc.results = lineEndingService.scanFiles(rc.dir);
		}
	}	
	
	
	function detail(event,rc,prc){
		rc.file = lineEndingService.getFileDetails(rc.fullPath);
	}	
	
}
