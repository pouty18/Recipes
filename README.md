### Summary: Include screen shots or a video of your app highlighting its features


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized the initial project arcitecture as well as an emphasis on ensuring simple ViewModel to make for easy testing.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I would say I spent somewhere between 10-20 hours on this. It was primarily broken up into quarters, whereas the first quarter I focused on just the data model. Building out the RecipeCore Swift Package and making sure I was happy with how it came together. Second, I worked on the Screens and their relationship to one another. This included wiring up the Filter, Settings, and RecipeDetail view to the RecipeListView. The third quarter I spent testing manually and writing unit tests. And the last quarter was refinement, so taking a few hours to make sure I didn't forget anything and that I'm generally satisfied with my project. For this, I tried to treat it as if this were an app I was actually going to build myself and continue working on.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I think one big trade off is that while I strived for a MVVM approach, I didn't necessarily follow that 100%. I elected to allow my view's access to the RecipeCore domain models. 

Context: I knew that I wanted a core framework or package that would house any important networking code and/or domain model code, so the decision to create RecipesCore was simple. What I wasn't sure of is whether or not the views I was creating should be "allowed" to have access to these Recipe Models through the ViewModels. 

In an alternate approach path, I was considering creating UIModels that would be the Screen's representation of the data it cared about or had knowledge of. In this approach, I would have had to map the domain models properties into UIModels. This would be taken care of by the ViewModel or a helper class. In my opinion, this created an unnecessary step in the data flow. If we need to change our domain model, say a Recipe for example, then the RecipeUIModel would likely also need to change.

The only other tradeoff I was considering was building a RecipeService or RecipeManager that would serve as an intermediary between the RecipesCore network code and a ViewModel. I decided off this since I didn't think I could come up with a cache invalidation policy that would make sense for the service/manager. It felt straight forward to fetch the data and display it as needed.  


### Weakest Part of the Project: What do you think is the weakest part of your project?
Two parts, the RecipeCore doesn't have amazing support for environment toggling and preview support. I wanted to model the Swift-Dependencies framework that I've recently worked with but ulitmately decided off that. Also, the RecipeDetail screen is something I added, but then didn't enhance in anyway. These are likely the weakest parts of the project in my opinion. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I don't have anything else. I enjoyed working with the three different endpoints and I thouroughly appreciate the detail involved in creating a relatively straightforward take home assessment. 
