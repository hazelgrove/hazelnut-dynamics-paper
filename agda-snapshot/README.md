# hazelnut-dynamics-agda
This repository is the mechanization of the calculus described in our
submission. It includes the full definitions of all the judgements and
metafunctions in the draft and proofs the theorems. There are a small
number of standard structural properties that are taken as postulates; the
specific statements can be found by running the BASH script
`postulates.sh`. Of these:

* one is function extensionality, which is known to be independent of Agda,
  and will not be removed

* one is the currently not-well founded definition of hole instantiation,
  and reformulating this is ongoing work

* the remaining four are standard structural properties that are being
  proved as ongoing work

In a sense, the theorems in the rest of the development can be taken as
being weakened by the conjunction of these six postulates.

It is a work in progress, so not every theorem is currently fully
proven. The theorems listed in [all.agda](all.agda) and not commented out
are proven in full, however.

# Description of Agda Files

## Meta Concerns
- [all.agda](all.agda) is morally a make file: it includes every module in
  every other file, so running `$ agda all.agda` on a clean clone of this
  repository will recheck every proof from scratch. It is known to load
  cleanly with `Agda version 2.5.1.1`; we have not tested it on any other
  version. There are three files commented out in this list: one is a
  partial, in-progress, proof of a lemma about substitution; the other two
  are statements of proofs about hole instantiation and commutativity that
  are future work.
- [structural-assumptions.agda](structural-assumptions.agda) is a file of
  postulates for standard structural properties about contexts and
  judgements that we have not yet proven. This will not be included in the
  final version of this mechanization, but it's helpful to have one place
  to look to know exactly what is being taken on faith and what's really
  proven. In a conservative sense, you can think of the rest of the
  theorems as being implied by in the postulates taken here rather than in
  their full form.


## Prelude and Datatypes

These files give definitions and syntactic sugar for common ideas from type
theory (sum types, products, sigmas, propositional equality, `transport`,
`ap`, etc.) and data structures (natural numbers and lists) that are used
pervasively throughout the rest of the development.

- [List.agda](List.agda)
- [Nat.agda](Nat.agda)
- [Prelude.agda](Prelude.agda)

## Core Definitions

- [contexts.agda](contexts.agda) defines contexts as functions from natural
  numbers to possible contents and proves the relevant lemmas and
  properties needed to make this definition usable.
- [core.agda](core.agda) gives definitions for all of the judgements used
  in the paper text and throughout the rest of the development. We have
  attempted to use unicode and mixfix to make the notation line up as well
  as possible with the on-paper notation without being unreadable.
- [structural.agda](structural.agda) contains the standard theorems about
  different hypothetical judgements enjoying properties of weakening,
  exchange, and contraction in their various context arguments. Right now,
  this file only includes postulates of those properties needed directly in
  the proofs of other theorems; as a matter of good housekeeping, these
  proofs will be completed and accompanied by proofs of the other
  properties that ought to be true but are not explicitly required to fill
  other proof obligations.

## Lemmas

These files contain technical lemmas for the corresponding judgement or
theorem. They are generally not surprising once stated, although it's
perhaps not immediately why they're needed, and tend to obfuscate the
actual proof text. They are corralled into their own modules in an effort
to aid readability.

- [disjointness.agda](disjointness.agda) contains more important lemmas
  about disjoint contexts.
- [focus-formation.agda](focus-formation.agda) proves the focus formation
  property.
- [ground-decidable.agda](ground-decidable.agda) proves that ground types
  are decidable
- [htype-decidable.agda](htype-decidable.agda) proves that the type system
  has decidable equality.
- [lemmas-consistency.agda](lemmas-consistency.agda) contains lemmas about
  the type consistency relation.
- [lemmas-complete.agda](lemmas-complete.agda) contains lemmas about
  complete types and expressions.
- [lemmas-disjointness.agda](lemmas-disjointness.agda) contains less
  important lemmas about disjoint contexts.
- [lemmas-gcomplete.agda](lemmas-gcomplete.agda) contains lemmas about
  complete contexts.
- [lemmas-ground.agda](lemmas-ground.agda) contains lemmas about ground
  types.
- [lemmas-matching.agda](lemmas-matching.agda) contains lemmas about
  matching types.
- [lemmas-progress-checks.agda](lemmas-progress-checks.agda) contains
  lemmas used in proving that the consequent sum from progress is pairwise
  disjoint.
- [lemmas-subst-ta.agda](lemmas-subst-ta.agda) contains lemmas used in the
  (currently partial) proof of the substitution lemma.
- [matched-ground-invariant.agda](matched-ground-invariant.agda) contains a
  proof of the matched ground invariant.
- [synth-unicity.agda](synth-unicity.agda) argues that the synthesis
  judgement produces at most one type for a term.
- [finality.agda](finality.agda) argues that a final expression only steps
  to itself.

## Theorems

### Canonical Forms

Together, these files give the canonical forms lemma for the language. They
are broken down in a slightly more explicit way than in the paper text,
each type getting its own theorem, for usability later.

- [canonical-boxed-forms.agda](canonical-boxed-forms.agda)
- [canonical-indeterminate-forms.agda](canonical-indeterminate-forms.agda)
- [canonical-value-forms.agda](canonical-value-forms.agda)

### Metatheory of Type Assignment

- [type-assignment-unicity.agda](type-assignment-unicity.agda) argues that
  the type assignment system assigns at most one type to any term.

### Metatheory of Expansion

- [expansion-generality.agda](expansion-generality.agda) argues that the expansion
  judgements respect the bidirectional typing system.
- [expandability.agda](expandability.agda) argues that any well typed term
  can be expanded to a dynamic term.
- [expansion-unicity.agda](expansion-unicity.agda) argues that expansion
  produces at most one result.
- [typed-expansion.agda](typed-expansion.agda) argues that the expansion
  respects the type assignment system.

### Type Safety

These first three files contain proofs of type safety for the core
language, where terms and types may both have holes in them and still step.

- [progress.agda](progress.agda) argues that any `dhexp` that gets assigned
  a type either steps, is a boxed value, or is indeterminate.
- [progress-checks.agda](progress-checks.agda) argues that the clauses in
  progress are disjoint---that is to say that no expression both steps and
  is a boxed value, etc.
- [preservation.agda](preservation.agda) argues that stepping preserves
  type assignment.

We also argue that our dynamics is a conservative extension in the sense
that if you use it to evaluate terms in the calculus that have no holes in
them, you get the same type safety theorems you might expect for the
restricted fragment without holes.

- [complete-expansion.agda](complete-expansion.agda) argues that the
  expansion of a complete term into the dynamic language produces another
  complete term.
- [complete-preservation.agda](complete-preservation.agda) argues that
  stepping a complete term produces a complete term that is assigned the
  same type.
- [complete-progress.agda](complete-progress.agda) argues that complete
  terms are either a value or step.
- [cast-inert.agda](cast-inert.agda) argues that a well-typed complete
  expression has only identity casts.


### Metatheory of Instantiation (Future Work)

- [commutativity.agda](commutativity.agda) gives the signature for an
  unproven theorem that argues that stepping respects hole instantiation.
- [instantiation.agda](instantiation.agda) gives the signature for an
  uproven theorem that argues that hole instantiation respects type
  assignment.
