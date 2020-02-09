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

![2](https://user-images.githubusercontent.com/37926234/74108459-c07a4f80-4b8b-11ea-8f86-229e5ad63cb9.png)
![3](https://user-images.githubusercontent.com/37926234/74108466-c7a15d80-4b8b-11ea-825c-3341919e5006.png)
![1](https://user-images.githubusercontent.com/37926234/74108477-d851d380-4b8b-11ea-87ab-5b95c1f39bad.png)
