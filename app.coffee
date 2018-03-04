# Import file "iOS_page"
sketch = Framer.Importer.load("imported/iOS_page@1x", scale: 1)
# make it easier to call layer object
Utils.globalLayers(sketch) 
selectedIndex = -1

# Set up pages
page = new PageComponent
	size: Screen.size
	scrollHorizontal: false
	scrollVertical: false
	
# Add pages vertically
page.addPage(state_01,"right")
page.addPage(state_02, "right")

# Button list
buttonList = [buttonVNeckS01, buttonCardiganS01, 
buttonCocktailS01,buttonMiniSkirtS01]

# Guided result list
guidedResults = ["thermal", "knit", "deep", "plunge", "vintage", "cosy", "tab", "ruched"]

# V neck image list
vneckImageList = 
	["https://s-media-cache-ak0.pinimg.com/originals/2f/5e/68/2f5e68fa2701d83f041c9f64a0f50a55.jpg",
	"https://s-media-cache-ak0.pinimg.com/originals/5a/77/78/5a7778d95b1d2ea024be3c1a9b6a3253.jpg", 
	"https://i.pinimg.com/564x/cf/51/94/cf5194ba577ebb07166051f1b93a2dba.jpg",
	"https://euimages.urbanoutfitters.com/is/image/UrbanOutfittersEU/0114418269731_001_b?$xlarge$&hei=900&qlt=80&fit=constrain",
	"https://images.urbanoutfitters.com/is/image/UrbanOutfitters/46677845_000_b?$xlarge$&hei=900&qlt=80&fit=constrain",
	"https://images.urbanoutfitters.com/is/image/UrbanOutfitters/43767821_001_b?$xlarge$&hei=900&qlt=80&fit=constrain",
	"https://images.urbanoutfitters.com/is/image/UrbanOutfitters/45340486_040_b?$medium$&qlt=80&fit=constrain",
	"https://images.urbanoutfitters.com/is/image/UrbanOutfitters/45099256_001_b?$xlarge$&hei=900&qlt=80&fit=constrain"
	]

# IDEA: Tap on V Neck button
# 1. V Neck morph to center, from eclipse to circle
# 2. Other buttons bounce out to the button
# 3. Morph out rounded selections

buttonVNeckS01.onTouchStart ->
	buttonVNeckS01.states.switch("pressing")
	
buttonVNeckS01.states.add
	pressing: 
		scale: 0.30
		brightness: 80
		time: 0.1
		curve: "ease-out"
		

buttonVNeckS01.onTap ->
	for i in [0...buttonList.length]
		if (buttonList[i].name == "buttonVNeckS01")
			buttonList[i].animate
				layer: buttonList[i]
				curve: "spring(70, 24, 200)"
				properties:
					y: Screen.height - 60
					x: Screen.width/2 - 50
					scale: 1.2
				delay: 0
		else
			buttonList[i].animate
				layer: buttonList[i]
				#delay: (i / 4) + 2
				#curve: "spring(" + (i * 200) + ", " + (i * 5) + ")"
				curve: "ease-in-out"
				properties:
					y: Align.bottom
					opacity: (0)
					#borderRadius: (i*10)
					rotation: (i*100)
				
# After v neck animation finished	
buttonVNeckS01.onAnimationEnd ->
	buttonVNeckS01.visible = false
	titleSuggestionS01.visible = false
	layerDrag = []
	layerDrag = new Layer width:128, height:128
	layerDrag.visible = false
	
	# Set color ring constraints 
	constrainFrame = new Layer width: Screen.width, height: 120, backgroundColor: "rgba(255,255,255,0)", borderRadius: 8
	constrainFrame.x = 10
	constrainFrame.y = Screen.height/2 + 50
	
	
	howToText = new TextLayer
		fontFamily: Utils.loadWebFont("Poppins")
		text: "DRAG YOUR STYLE\n\nrainbow knows your outfit and mood"
		color: "#000"
		textAlign: "center"
		fontSize: 16
		fontWeight: 300
		width: 200
		height: 140
# 		parent: layerDrag[index]
		
	howToText.center()
	# Eliminate image number to be better showing layout
	for vneckIndex in [0...vneckImageList.length-4]
		# print vneckIndex
		# vneckIndex = parseInt(Utils.randomNumber(0,7))		
		# Create v neck image
		#dragState = "none"
		CreateDragImage = (index) ->
			dragState = "init"		
			# Create a new layer to drag
			dragImage = [vneckImageList.length-4] #only use 4 data
			if (dragImage[index])
				dragImage[index].destroy
			
			dragImage[index] = new Layer 
								width:80, height:80
								x: 90*index + 15
								y: Screen.height-20*index
															
			dragImage[index].animate
				layer: dragImage[index]	
				curve: "easeInQuart"
				properties: 
					y: Screen.height - 120
				time: 1
				
			dragImage[index].image = vneckImageList[index]
			
			dragImage[index].style =
				borderRadius: '60%',
				boxShadow: 'inset 0 0 0 3px #fff, 0 4px 12px rgba(0,0,0,0.1)'
				
			# Make the layer draggable
			dragImage[index].draggable.enabled = true
			layerDrag[index] = dragImage[index]
			
			# Set the constraints frame (x, y, width, height)
			dragImage[index].draggable.constraints = constrainFrame.frame
			
			# Customize the momentum animation
			dragImage[index].draggable.momentumOptions = {
				friction: 10
				tolerance: 0.5
			}
			
			# Customize the bounce animation
			# We make it snap back to its constraints really quickly
			dragImage[index].draggable.bounceOptions = {
				tension: 400
				friction: 30
			}
			
			selectedColor = 0
			dragImage[index].on Events.Move, (offset) ->
				if (dragState == "end")
					return
				
				dragState = "move"
				#print "draggg..." + index
				# Map the dragging distance to a number between 0 and 1 
				fraction = Utils.modulate(offset.x, [0, Screen.width], [0,1], true)
				# TOFIX: fake color selection
				# Mix the colors, enable the limit, transition in HUSL 
				selectedColor = Color.mix("red", "green", fraction, true, "husl")	
				dragImage[index].style =
				borderRadius: "80%",
				boxShadow: "inset 0 0 0 3px "+selectedColor+", 0 4px 12px rgba(0,0,0,0.1)"
					
			# After drag end
			dragImage[index].onDragEnd ->
				#print "drag: end" + ",i:" + index + ", size: " + dragImage.length
				dragState = "end"
				# print index
				dragImage[index].visible = false			
				howToText.visible = false
				selectedIndex = index
				page.snapToNextPage() # navigate to 2nd page
				# Image placeholder
				layer = new Layer
					image: "https://goo.gl/rkq5Qo"
					borderRadius: 4
					x: 4
					y: 230
					scale: 0.7
					
				layer = new Layer
					image: "https://goo.gl/Uo6K7R"
					borderRadius: 4
					x: 4 + 170
					y: 230
					scale: 0.7
				
				state_02.backgroundColor = selectedColor
				
				if (selectedIndex == 0)
					layer = new Layer
						image: "https://goo.gl/2w1X6d"
						borderRadius: 4
						x: 4
						y: 230
						scale: 0.7
						
					layer = new Layer
						image: "https://goo.gl/GA7Hc7"
						borderRadius: 4
						x: 4 + 170
						y: 230
						scale: 0.7
				else if (selectedIndex == 1)
					layer = new Layer
						image: "https://goo.gl/h8UzAL"
						borderRadius: 4
						x: 4
						y: 230
						scale: 0.7
						
					layer = new Layer
						image: "https://goo.gl/GA7Hc7"
						borderRadius: 4
						x: 4 + 170
						y: 230
						scale: 0.7
				else if (selectedIndex == 2)
					layer = new Layer
						image: "https://goo.gl/GA7Hc7"
						borderRadius: 4
						x: 4
						y: 230
						scale: 0.7					
					layer = new Layer
						image: "https://goo.gl/h8UzAL"
						borderRadius: 4
						x: 4 + 170
						y: 230
						scale: 0.7
				else if (selectedIndex == 3)
					layer = new Layer
						image: "https://goo.gl/h8UzAL"
						borderRadius: 4
						x: 4
						y: 230
						scale: 0.7
					layer = new Layer
						image: "https://goo.gl/GA7Hc7"
						borderRadius: 4
						x: 4 + 170
						y: 230
						scale: 0.7
				# After drag animation
# 				dragImage[index].on Events.DragAnimationEnd, ->
# 					print "drag animation ended"
# 					dragImage[index].visible = false
# 					page.snapToNextPage() # navigate to 2nd page

			# TOFIX: disable this since too many bugs
			# state 02 -> state 01
# 			Left_Accessory.onTap ->
# 				page.snapToPreviousPage()
# 				howToText.visible = true
# 				# TOFIX: quick hack, should use array length
# 				for i in [0...4]
# 					if (dragImage[i])
# 						dragImage[i].destroy
# 						dragImage[i].visible = false
# 					
# 				CreateDragImage(i)
# 				CreateSuggestionText(i)
					
				
		# Create v neck suggestion text
		CreateSuggestionText = (index) ->
			guidedText = new TextLayer
				fontFamily: Utils.loadWebFont("Poppins")
				text: guidedResults[index]
				color: "#fff"
				textAlign: "center"
				fontSize: 16
				fontWeight: 600
				width: 100
				height: 40
				parent: layerDrag[index]
				
			guidedText.center()
		
		# Show v neck text and image
		# Harry's note: layer matters
		CreateDragImage(vneckIndex)
		CreateSuggestionText(vneckIndex)
		
	# Show color ring
	circleArray=[[510*2,410*2,7.38095,7.38095,0.5,7.38095, 7.38095 ,"rgba(0,205,0,0.5)",0.93,1.01,1],
		[510*2,410*2,2.70635,2.70635,0.5,7.38095, 7.38095,"rgba(205,0,0,0.5)",0.93,1.01,1],
		[510*2,410*2,7.38095,7.38095,0.5,7.38095, 7.38095,"rgba(0,0,205,0.5)",0.93,1.01,1],
		[320.134*1.5,320.134*1.5,35.433,35.433,0.5,4.42857-4, 0,"White",0.94,1,0.1],
		[320.134*1.5,320.134*1.5,35.433,35.433,0.5,4.42857-4, 0,"White",0.94,1,0.1],]
	rotateLayer = (layer,mode)->
		if mode
			layer.rotationZ = layer.rotationZ + Utils.randomNumber(1,5)
		else
			layer.rotationZ = layer.rotationZ - Utils.randomNumber(3,15)

	index = 0
		
	for item in circleArray
		SqureParent = new Layer
			height:item[1]
			width:item[0] 
			parent: state_01
# 			x:item[3]
# 			y:item[2]
			x: Align.center
			y: Screen.height - 220
			name:index
			backgroundColor: "Transparent"
		Circle = new Layer
			borderRadius: item[0]/2
			width: item[0]
			height: item[1]
			opacity: item[4]
			x:item[6]
			y:item[5]
			backgroundColor: item[7]
			scaleX: item[8]
			scaleY: item[9]
			scaleZ:item[10]
			parent: SqureParent
			style: "background-blend-mode": "multiply"
		index++

	timeInterval = 0.10
	Utils.interval timeInterval,->
		for item in state_01.children	
			if (item.name == "navigationBarSearchS01" ||
			item.name == "buttonVNeckS01" ||
			item.name == "titleSuggestionS01")
				continue
				
			if parseInt(item.name) % 2 == 0
				rotateLayer(item,false)
				
			else
				rotateLayer(item,true)