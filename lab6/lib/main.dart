import 'package:flutter/material.dart';

void main() => runApp(const ResponsiveMovieApp());

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

const List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/inception/200/300',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/darkknight/200/300',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/interstellar/200/300',
    rating: 8.6,
  ),
  Movie(
    title: 'The Grand Budapest Hotel',
    year: 2014,
    genres: ['Comedy', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/budapest/200/300',
    rating: 8.1,
  ),
  Movie(
    title: 'Mad Max: Fury Road',
    year: 2015,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://picsum.photos/seed/madmax/200/300',
    rating: 8.1,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: ['Drama', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/parasite/200/300',
    rating: 8.5,
  ),
  Movie(
    title: 'The Hangover',
    year: 2009,
    genres: ['Comedy'],
    posterUrl: 'https://picsum.photos/seed/hangover/200/300',
    rating: 7.7,
  ),
  Movie(
    title: 'Avengers: Endgame',
    year: 2019,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://picsum.photos/seed/endgame/200/300',
    rating: 8.4,
  ),
];

const List<String> allGenres = [
  'Action',
  'Drama',
  'Comedy',
  'Sci-Fi',
  'Thriller',
];

const List<String> sortOptions = ['A–Z', 'Z–A', 'Year', 'Rating'];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find a Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  final Set<String> selectedGenres = {};
  String selectedSort = 'A–Z';

  List<Movie> get visibleMovies {
    var filtered = allMovies.where((movie) {
      final matchesSearch =
          searchQuery.isEmpty ||
          movie.title.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesGenre =
          selectedGenres.isEmpty ||
          movie.genres.any((g) => selectedGenres.contains(g));

      return matchesSearch && matchesGenre;
    }).toList();

    switch (selectedSort) {
      case 'A–Z':
        filtered.sort((a, b) => a.title.compareTo(b.title));
      case 'Z–A':
        filtered.sort((a, b) => b.title.compareTo(a.title));
      case 'Year':
        filtered.sort((a, b) => b.year.compareTo(a.year));
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 12),
              _buildGenreChips(),
              const SizedBox(height: 12),
              _buildSortBar(),
              const SizedBox(height: 12),
              Expanded(child: _buildMovieList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Row(
      children: [
        const Icon(Icons.movie_filter, color: Colors.deepPurpleAccent, size: 28),
        const SizedBox(width: 8),
        const Text(
          'Find a Movie',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (selectedGenres.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${selectedGenres.length} genre${selectedGenres.length > 1 ? 's' : ''}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.4)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Search movies...',
          hintStyle: TextStyle(color: Colors.white38),
          prefixIcon: Icon(Icons.search, color: Colors.white38),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
        onChanged: (value) => setState(() => searchQuery = value),
      ),
    );
  }

  Widget _buildGenreChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Genres',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (selectedGenres.isNotEmpty)
              GestureDetector(
                onTap: () => setState(() => selectedGenres.clear()),
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 12),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allGenres.map((genre) {
            final isSelected = selectedGenres.contains(genre);
            return GestureDetector(
              onTap: () => setState(() {
                if (isSelected) {
                  selectedGenres.remove(genre);
                } else {
                  selectedGenres.add(genre);
                }
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.deepPurpleAccent
                      : const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.deepPurpleAccent
                        : Colors.white24,
                  ),
                ),
                child: Text(
                  genre,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 13,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortBar() {
    return Row(
      children: [
        const Text(
          'Sort by:',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSort,
              dropdownColor: const Color(0xFF1E1E2E),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
              items: sortOptions
                  .map(
                    (opt) => DropdownMenuItem(
                      value: opt,
                      child: Text(opt),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => selectedSort = value);
              },
            ),
          ),
        ),
        const Spacer(),
        Text(
          '${visibleMovies.length} result${visibleMovies.length != 1 ? 's' : ''}',
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMovieList() {
    final movies = visibleMovies;

    if (movies.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: Colors.white24, size: 48),
            SizedBox(height: 12),
            Text(
              'No movies found',
              style: TextStyle(color: Colors.white38, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.8,
            children: movies.map((m) => _buildMovieCard(m, wide: true)).toList(),
          );
        }
        return ListView.separated(
          itemCount: movies.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => _buildMovieCard(movies[i], wide: false),
        );
      },
    );
  }

  Widget _buildMovieCard(Movie movie, {required bool wide}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final posterWidth = wide ? 70.0 : 60.0;
        final posterHeight = wide ? 100.0 : 90.0;

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterUrl,
                  width: posterWidth,
                  height: posterHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: posterWidth,
                    height: posterHeight,
                    color: Colors.deepPurple.withOpacity(0.3),
                    child: const Icon(Icons.movie, color: Colors.white24),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.year.toString(),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: movie.genres
                          .map(
                            (g) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                g,
                                style: const TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(height: 2),
                  Text(
                    movie.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
