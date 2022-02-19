# WLAN_planning_tool
User received power from the 5 Aps. 
Using the received power, plot the value of the received power every 0.5 m (or any other reference point) from the AP location and extended to the building area of coverage. 
Then, Given a certain power received profile from the 5 APs you should return an estimate location for the user.

The two basic methods of finding the position of the user given the signals strength of APs are Location signature/fingerprinting: 
This technique searches the given input signals pattern with all the other signals in the database and match with the point which 
corresponds to the nearest neighbor in the signal hyperspace. 
This can be computed by calculating the least square of the test signals pattern and the other points signal pattern recorded during (1) 
and selecting the point with the least distance.
