 ARtIST - AnotheR IoS Toolkit
======

Yes! this is another iOS utilities/toolkit bag of code. There is nothing special about this toolkit, the only "diference" is that I will be working to make this bag more like a closet, where you can find what you looking for relatively fast.

For accomplish this mission **all** the code in this repo **must** follow this simple rules:

1. The tools must by organized in the following directory structure:

		ARtIST
			|
				->[tool name]
				|
				-> [XCode Project]
					|
					-> [tool name: this directory must have all the code needed for the tool to work]
					README.md
This way if I want to integrate this tool all I need is inside the folder "[tool name]" inside de XCode project.

2. The "README.md" file iside a tool folder must have this format:

        Title
        =====
        Description of the tool
        
        Provide
        -------
        Briefly description of what classes the tool provide and what they do. There is no need to explain the internal classes, only the ones that are public to the consumer.
        
        Require
        -------
        If the tool need other third party code / libraries they should be enumerated here.
        
        Contraints
        ----------
        If the tool have any constraint they should appear here. (ex: iOS > 5)
        
        Notes
        -----
        Any other thing that the consumer should know.

That's all. Hope you enjoy it as much as I do :)