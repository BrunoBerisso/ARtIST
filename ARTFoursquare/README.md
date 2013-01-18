ARTFoursqure
==========

ARTFoursqure is a easy to use session handler for Foursquare similar to FacebookSDK that wraps [BZFoursquare](https://github.com/baztokyo/foursquare-ios-api). It provide the mechanism to start a request without the need of handling the login callbacks and a partial model for the Foursquare objects. Most of the work is done by BZFoursquare.

All the code do you need to use this classes is in the ARTFoursquare folder inside the project.

Provide
-----------
The classes provided are:

* ARTFursquare: the main class is a singleton. Holds a reference to the session and start the requests
* ARTFoursquareCategory: a model object model for Fousquare's categories
* ARTFoursquareLocation: a model object model for Fousquare's locations
* ARTFoursquareVenue: a model object model for Fousquare's venues

Require
-----------
The only requirement is [BZFoursquare](https://github.com/baztokyo/foursquare-ios-api) and, of course, his dependencies.

Contraints
--------------
This clases are with iOS 5.0 or later and **without ARC**

Notes
--------
The [example project](https://github.com/baztokyo/foursquare-ios-api/tree/master/FSQDemo) for BZFoursquare use a "User-defined" setting for set the client id and callback to use. I choose to use a method to set this values in ARTFoursquare because I don't want to be responsable for how do you manage your constants.