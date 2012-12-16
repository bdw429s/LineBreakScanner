component {
	
	// Module Properties
	this.title 				= "Line Break Scanner";
	this.author 			= "Brad Wood";
	this.webURL 			= "http://www.codersrevolution.com";
	this.description 		= "I scan your code files and tell you what kind of line breaks they use.";
	this.version			= "1";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "lineBreakScanner";
	
	function configure(){
		
		// SES Routes
		routes = [
			"config/routes.cfm"
		];
		
		// Binder
		binder.map("LineEndingService@lineBreakScanner").to("#moduleMapping#.model.LineEndingService");
	}
	
}