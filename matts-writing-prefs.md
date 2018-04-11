Matt's Writing Preferences
=============================

Below, I am cataloging my writing preferences.

I think that some these suggestions are especially important for reading
really wide columns of text, as in this new PACMPL format. :)

Grammar (within a single sentence)
-----------------------------------

- **Use short active sentences, where the subject is close to its verb.**

- Use **singlar** over plural sentence subjects, whenever possible.

- Use **present tense**; I prefer the phrasing "Hazelnut defines" not
  "Hazelnut defined" --- temporal ordering in "idea space" is
  inherently confusing to a reader that encounters papers in a
  different order than chronologically

- Prefix each greek letter with an English word 'classifier',
  e.g., `expression~$e$`, not just `$e$`.


### Please avoid these anti-patterns:

- Avoid passive voice.  Active voice gives the reader a more
  comprehensible and enjoyable narrative to digest.

  So, use "We", some aspect of the paper itself "Section X"/"Figure
  Y", or some interesting concept in the paper "Judgement Z" as the
  subject of the sentence.  Doing so also permits the author to choose
  a more interesting verb than 'is' for the sentence.
	
  Hint: To check your writing in a semi-automated way, count
  occurrences of the word 'is'; In Emacs, try doing `count-matches`
  with `\b\is\b`.

- Avoid giving the paper a "temporal structure". Phrases such as "X
  will be discussed later" imply a temporal ordering to the paper's
  sections.  Instead, the paper should refer to itself *spatially*,
  not *temporally* e.g., "We discuss X further below", or "Sec Y
  discusses X in further detail", _not_ "X will be discussed further
  later".  (I read and think through papers in a highly non-linear
  fashion, so temporal references make no sense to me as I read)

- Avoid using lots of commas. Each 'extra' comma is a burden to the
 reader (it's asking the reader to either allocate or pop a stack
 frame in their brain!)
 

Multi-sentence and paragraph structure
------------------------------------------

- Use short sentences in active voice.

- Avoid numerous parenthenticals: just use more sentences instead.

- Use short paragraphs, with a defined 'paragraph structure'. (E.g.,
  topic sentence, supporting sentences, and lead to the next idea in
  the next paragraph)

- If a sentence introduces a figure, that sentence should be the first
 sentence of a paragraph, and the figure reference should be the first
 word of that sentence, ideally.  As a reader, then I look at figures
 first, and find the paragraphs for them easily by scanning the text.

- Citations in this Names+Year form break sentence and paragraph
 flow for the reader, sometimes quite severly.  Put long citation
 chains at the ends of sentences (or better yet, in their own little
 paragraph, as I did below).


Paper structure: Intro section
--------------------------------
TODO

Paper structure: Overview section
-----------------------------------
TODO



Latex-specific
-----------------

- Please, please please: Use line breaks.  Git does't work well
  without them.  If necessary, please change your editor or editor
  settings.

- I put a blank latex comment between each sentence; my emacs mode
  will not line-wrap beyond those comments, and will preserve the line
  breaks that follow them.

- Use macros for fig and section references.
