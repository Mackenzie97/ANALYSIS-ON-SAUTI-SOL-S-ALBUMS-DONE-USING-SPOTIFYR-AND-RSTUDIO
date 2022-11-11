#install the spotify r package
install.packages("spotifyr")
library(spotifyr)
library(tidyverse)
# save this libraries so that we dont need to keep loading them everytime

Sys.setenv(SPOTIFY_CLIENT_ID = '962fb46de32544d9bba815ffb61e90a0')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '55c1119bba1d4603ba1ca5324d5d8ecb')

access_token <- get_spotify_access_token()

library(dplyr)
library(purrr)
library(knitr)
library(lubridate)


#
# Use localhost:14101 to authenticate
get_my_recently_played(limit = 5) %>%
  mutate(
    artist.name = map_chr(track.artists, function(x) x$name[1]),
    played_at = as_datetime(played_at)
  ) %>%
  select(all_of(c("track.name", "artist.name", "track.album.name", "played_at"))
  ) %>%
  knitr::kable()

# The sauti sol from Kenya

sauti <- get_artist_audio_features('sauti sol')
View(sauti)
summary(sauti)

# Tracks with - valence (sad/depressing)
sauti %>%
  arrange(-valence) %>%
  select(.data$track_name, .data$valence) %>%
  head(5) %>%
  knitr::kable()

# Tracks with + valence
sauti %>%
  arrange(valence) %>%
  select(.data$track_name, .data$valence) %>%
  head(10) %>%
  knitr::kable()

# Sauti sol plot of sauti sol's joy distributions Across Their Albums
# Picking joint bandwidth of 0.0928

library(ggplot2)
library(ggridges)

ggplot(
  sauti,
  aes(x = valence, y = album_name)
) +
  geom_density_ridges() +
  theme_ridges() +
  labs(title = "JOY PLOT OF SAUTI SOL'S JOY DISTRIBUTIONS ACROSS THEIR ALBUMS",
       subtitle = "Based on valence pulled from Spotify's Web API with spotifyr
                  Valence Describes the musical positiveness conveyed by a track")


#SAUTI SOL'S ENERGY DISTRIBUTIONS ACROSS THEIR ALBUMS
# The picking joint Bandwidth of 0.0666

ggplot(
  sauti,
  aes(x = energy, y = album_name)
) +
  geom_density_ridges() +
  theme_ridges() +
  labs(title = "A PLOT OF SAUTI SOL'S ENERGY DISTRIBUTIONS ACROSS THEIR ALBUMS",
       subtitle = "Based on energy pulled from Spotify's Web API with spotifyr
                  Energy Represents a perceptual measure of intensity and activity.")


# Danceability,Describes how suitable a track is for dancing based on a combination of musical elements including;tempo,rhythm stability, beat strength, and overall regularity
# picking joint bandwidwith of 0.0486
ggplot(
  sauti,
  aes(x = danceability, y = album_name)
) +
  geom_density_ridges() +
  theme_ridges() +
  labs(title = "A PLOT OF SAUTI SOL'S DANCEABILITY DISTRIBUTIONS ACROSS THEIR ALBUMS",
       subtitle = "Based on danceability pulled from Spotify's Web API with spotifyr
                  Danceability is based on combination of musical elements including;tempo,
                   rhythm stability, beat strength, and overall regularity.")


