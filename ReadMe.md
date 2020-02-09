###########################
Movie List app
###########################

*list screen has a collection view.
*Collection view layout can change by button on right top corner.
*Movie poster images downloaded from url. I didn't use cache for images. But for performance cache can be use. 
And multiple image downlod can be use for this app.

* I did generic methods in network service for api calls
* There is no need to call movie detail api. All fields in movie list api
* I saved favorite movie id's to user defaults(also it can be done with core data).
* After adding favorite, i triggered a notification for update main collection view cell update.(just reloaded related cell)

* 2 very simple test cases.