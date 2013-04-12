An amazingly bad IRC bot for auto-opping some of #atx2600's users, as well as 
for tracking bragging rights karma and some other crud.

Built atop Perl and IRSSI at the moment as it was the minimum viable IRC bot, 
will probably be rewritten either to Python, pure Perl (over my dead body but 
possible) or Clojure.

## Todo
 - Settle on a better name for this silly thing
 - Modularize this somehow so that commands can be defined individually and loaded in some reasonably architected manner rather than being defined in one friggin huge if statement.
 - Back the karma system with a real datastore rather than a simple map.
 - Migrate the auto-op stuff in, backing it with a real datastore as well.
 - Add a URL saving feature, allowing for a "links of #atx2600" page HN style.
 - Add some sort of rep store for users, being ppl who have made it to meetings vs random people who joined the chan for some reason.
