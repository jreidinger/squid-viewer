== Squid Viewer ==
Goal of this rails application is to provide way how to view and download content of squid cache.
Main usage is to have fallback when target site goes down and some content from cache is needed
to be extracted.
It is currently hard-coded to show only rpm and iso files, but it is quite easy to change it in
sync script.

=== Usage ===
Beside common rails deployment it also need regular refresh of cache content. Recommended way is
to add to cron line with call to `script/sync_cache.rb`.

