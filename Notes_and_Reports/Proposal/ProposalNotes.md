# Proposal Prep

This is just a space for me to brainstorm and track my ideas that are immediately related to my thesis proposal.

## Big Ideas :bulb:

For this proposal/thesis, the big ideas I want to focus on are:

- Construct _skip-gram_ networks to represent the text/document data.
  * vary filter/skip size; find the best size of skip, in terms of computation speed and accuracy?
  * weight edge by length of skip. How does this influence later steps?
- How do (labeled) graph kernels work on such a graph?
  * Do they perform well? We can compare to LDA.
  * Is computation expensive? Possible? Easy?
  * How to compute efficiently in R?
- Which common (unsupervised) ML algorithms work best with graph kernels for _skip-gram_ networks. 
  * k-means
  * hierarchical clustering
  * DBSCAN
  * t-sne
  * PCA
  * etc.
  
  
## Elevator Pitch :hourglass:

"We can represent a document or blob of text as a network of words. This network, constructed of _bi-grams_ (or generally _n-grams_), is a representation where a word is connected to another word if they appear adjacent to each other in text. What if we extend this network and construct connections which "reach" further ahead and further behind than bi-grams? These are a special case of n-grams called "**skip-grams**". This would build a _richer_ graph to represent the text with.

Why would we want to do this?

This network, being a representation of the text, can be used in other machine learning algorithms. Before they are used in the algorithms, we need a measure of _how similar one graph is to another_. We can achieve this through use of modern methods using **graph kernels**. These kernels enable us to have a measure of similarity between graphs, and they come in a few different flavors. This thesis will focus on the use of random walk kernels (for the time being) on _skip-gram networks_ as a preprocessing step for popular clustering algorithms.

The use of these two concepts in conjunction has potential use cases in any text mining. Examples may include: social media comments, news articles, doctor dictation notes, technical reports, or even books. This approach to text mining is not widely implemented, and would benefit from additional study on the effectiveness with varying types/lengths of text data, or from assessing varying parameters and their effects on the similarity measure.

## To-Do :pencil:

- ~~Make edits to "Elevator Pitch"~~

- ~~Short research on "skip-gram"~~

- ~~Do more research on graph kernels and skip grams~~

- Check datasets from _Nikolentzos_ paper.

