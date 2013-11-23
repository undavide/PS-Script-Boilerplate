`#target photoshop`

# Globally available variables wrapped in a Object literal
G = {
	# script's result
	result: undefined
	# script's status
	status: ""
	errorMessage: ""
	# current script path (with final forward-slash)
	path: "#{File($.fileName).path}/"
	# dialog vars
	dlg: {
		# copyright string
		copyright: "www.davidebarranca.com"
		# default parameters for the Dialog
		defaultParam: { }
	}
}

class MyClass
	
	###
	 * Constructor: called when the class is istanciated
	 * Checks for prerequisites
	 * Pre-processes the image [optional]
	 * @return {void}
	###
	constructor: () ->

		###
		 * Tests whether the open Document is suitable for further processing
		 * Sets G.errorMessage and G.result if the image doesn't pass the test
		 * @return {Boolean} true if everything's OK
		###
		checkPrerequisites = () ->
			# checkPrerequisites
			# if OK 
			# 	return true
			# else 
			# 	G.errorMessage = "..."
			# 	G.result = 'cancel'
			# 	return false
			# checkPrerequisites EOF
		
		###
		 * Pre-processes the image (if/when needed)
		 * Set G.errorMessage and G.result if the pre-process goes wrong
		 * @return {void} [description]
		###
		preProcess = () ->
			# ...
			# unless preProcess is OK 
			# 	G.errorMessage = "..."
			# 	G.result = 'cancel'
			# preProcess EOF

		if checkPrerequisites() then preProcess()
		# constructor EOF
	
	###
	 * Creates a ScriptUI Window of type 'dialog'
	 * @return {Window} The Dialog
	###
	createDlg: () ->
		win = new Window('dialog')
		@dlg = win
		# createDlg EOF

	###
	 * Initializes the Dialog with:
	 * Default GUI components values (from G.dlg.defaultParam)
	 * Components EventListeners and Callbacks
	 * @return {void}
	###
	initDlg: ()	->
		# reference to 'this' to be used inside callbacks
		that = @
		# Object literal that will contain GUI components values
		@param = {}
		# initDlg EOF
	
	###
	 * Shows the Dialog
	 * @return {Number} if OK then 1, else 2 (cancel)
	###
	runDlg: () ->
		@dlg.show()
		# runDlg EOF
	
	###
	 * Actual Photoshop routine based on GUI parameters
	 * Sets G.result to 'MC' in case everything's OK
	 * @return {[type]} [description]
	###
	postProcess: () ->
		
		###
		 * Cleans up things in case something 
		 * goes wrong in the post-processing
		 * @return {void}
		###
		cleanUp = () ->
			# ...
			# cleanUp EOF
		
		# Save current Preferences
		# ...
		# Set new Preferences
		# ...
		
		try
			# ...
			G.result = 'MC'

		catch e
			cleanUp()
			# Restore old Preferences
			# ...
			G.result = 'cancel'
		
		# postProcess EOF

###
try
	mC = new MyClass()
	if G.result is 'cancel' then throw new Error G.errorMessage
	mC.createDlg()
	mC.initDlg()
	if mC.runDlg() is 1 then app.activeDocument.suspendHistory "mC Script", "mC.postProcess()"

catch e
	alert "#{e.message}"

finally
	G.result
	
###

main = () ->
	try
		mC = new MyClass()
		if G.result is 'cancel' then throw new Error G.errorMessage
		mC.createDlg()
		mC.initDlg()
		if mC.runDlg() is 1 then mC.postProcess()
	catch e
		alert "#{e.message}"

app.activeDocument.suspendHistory "mC Script", "main()"
###
TODO: Fix suspendHistory in order to include preProcess()
###