## Guided Search Prototype
This is a Guided Search prototype created by Harry using Framer and Sketch as prototype tools

![Guided search prototype](https://media.giphy.com/media/2xPPD5n2ERJTJi83aQ/giphy.gif)

[Live Demo](https://framer.cloud/nslkn) here!! :rocket:


### Description
This prototype showcases few outcomes and hope can bring further discussions,

There are few broad concepts and ideas under the hood,

1. Visualization:  
To visualize different types of 'V Neck' clothes, For example: deep v neck, vintage v neck, etc. 
From my personal experience, I can't really tell what's difference among those different v neck. I'm always wondering, what's the name for styles? how does deep, vintage look like? 

2. Intelligence:  
After user is selecting one specific style, user can then drag one of the v neck style picture with matching rainbow colors showing on the screen. (In this prototype, I only demo the color matching concept, the color matching outline should be associated where the rainbow color user is dragging on) 

3. Playful experience:  
In the result page, user can always drag the other styles with colors to explore more.


The idea I want to explore is what if "color-matching behavior" stands more meanings?  
It might not necessary stand for selecting apparel's color only but could be every colorful imaginations out of user's mind. For example, the color of party theme coming tonight? your current feeling, mood associated with colors? the sky of your next trip? the smell of the cafe you're at, etc. I'm trying to imagine there's an AI engine behind this search, the process of selecting colors in the prototype can be related to different scenarios of user's life, but not only limited to only filter out apparel’s color. 

### The Prototype
This prototype tries to blend a specific search (style) with heuristic search (colors).

1. A Coffee script code based, live-demo prototype made by Framer and Sketch 
2. Use Framer animation library to guide the user through the interface. 
3. No offline data. Borrow images assets from Zalando, Urban Outfitters' website. Use web font from Google. 
4. Imagine how the experience might be before or after these two steps?

   * State 00 - Before selection  
   When user type keywords for searching, there might be suggested keywords popup.
      
   * State 01 - Style selection  
   Animation leads the visual from top to the bottom by using Spring, ease-in-out animation
   ![Styel Selection](https://i.imgur.com/tJUfOJX.png)
  
   
   . State 01.01 - color matching  
   Color rainbow animation helps user create colorful imagination and also a easy way to explore, select colors for the style.
   Ease-in animations for style bubbles are gently coming from the bottom to connect the visual from State 01.  
   When user drags style picture to color rainbow, the color of style bubble outline will refect the color where user drags on. 
   
   ![Styel Visualization](https://i.imgur.com/GmcCRgE.png)
   ![Styel Visualization](https://i.imgur.com/4jAZPsM.png)
     
   . State 02 - search result  
   When user drags and release the style icon, we will show the result immediately based on the style and colors.  
   
   ![Styel Visualization](https://i.imgur.com/2SizV90.png)

   
   
   . State 02.01 - explore more style with colors  
   User can keep exploring different styles and colors based on the same user experience (drag, move and release) on the same page.  
   
    ![Styel Visualization](https://i.imgur.com/zGH6PpH.png)
    ![Styel Visualization](https://i.imgur.com/LOCfMzP.png)  
    
    (Background color visualizes different result by colors for prototyping purpose, images here are just for placeholder)

   
  



