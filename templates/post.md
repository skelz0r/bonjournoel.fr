---
layout: christmas_post
title: Jour {{ number }}
date: {{ date }}

christmas_tree_image_url: {{ christmas_tree_image_url }}

debat: {{ debat }}

spotify_track_id: {{ spotify_track_id }}

gift_name: {{ gift.name }}
gift_url: {{ gift.url }}
gift_image_url: {{ gift.image_url }}
gift_tags: [{{ gift.tags }}]

recipe_name: {{ recipe.name }}
recipe_url: {{ recipe.url }}
recipe_image_url: {{ recipe.image_url }}
recipe_tags: [{{ recipe.tags }}]

movie_name: {{ movie.name }}
movie_url: {{ movie.imdb_url }}
movie_image_url: {{ movie.image_url }}
---
{% raw %}
{{ content }}
{% endraw %}
