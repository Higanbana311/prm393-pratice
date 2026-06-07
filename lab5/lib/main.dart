import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late List<Map<String, dynamic>> _movies;

  static const List<Map<String, dynamic>> _fixedMovies = [
    {
      'id': 'dune-2',
      'title': 'Dune: Part Two',
      'overview':
          'Paul Atreides unites with Chani and the Fremen while seeking revenge '
              'against the conspirators who destroyed his family.',
      'genres': ['Sci-Fi', 'Adventure', 'Drama'],
      'rating': 8.7,
      'accentColor': Color(0xFF9A6B3D),
      'posterIcon': Icons.landscape_rounded,
      'isFavorite': false,
      'trailers': [
        {'title': 'Official Trailer 2', 'duration': '2m 31s'},
        {'title': 'The Fremen Featurette', 'duration': '1m 42s'},
        {'title': 'Cast Interview', 'duration': '4m 06s'},
      ],
    },
    {
      'id': 'spider-verse',
      'title': 'Spider-Man: Across the Spider-Verse',
      'overview':
          'Miles Morales crosses the multiverse, meets other Spider-People, '
              'and must define heroism on his own terms.',
      'genres': ['Animation', 'Action', 'Family'],
      'rating': 8.9,
      'accentColor': Color(0xFFCD2E3A),
      'posterIcon': Icons.bolt_rounded,
      'isFavorite': false,
      'trailers': [
        {'title': 'Official Trailer', 'duration': '2m 28s'},
        {'title': 'Behind the Animation', 'duration': '3m 17s'},
        {'title': 'Meet Spider-Gwen', 'duration': '1m 21s'},
      ],
    },
    {
      'id': 'oppenheimer',
      'title': 'Oppenheimer',
      'overview':
          'The story of J. Robert Oppenheimer and the pressure, politics, and '
              'moral cost behind the atomic bomb.',
      'genres': ['Biography', 'History', 'Thriller'],
      'rating': 8.5,
      'accentColor': Color(0xFF7B342B),
      'posterIcon': Icons.local_fire_department_rounded,
      'isFavorite': false,
      'trailers': [
        {'title': 'Main Trailer', 'duration': '2m 12s'},
        {'title': 'Christopher Nolan on IMAX', 'duration': '2m 58s'},
        {'title': 'The Story of Oppenheimer', 'duration': '3m 44s'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _movies = _fixedMovies.map((movie) => Map<String, dynamic>.from(movie)).toList();
  }

  void _toggleFavorite(String movieId) {
    setState(() {
      _movies = _movies.map((movie) {
        if (movie['id'] != movieId) {
          return movie;
        }

        return {
          ...movie,
          'isFavorite': !(movie['isFavorite'] as bool),
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Navigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE85D04),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF111111),
        useMaterial3: true,
      ),
      home: HomeScreen(
        movies: _movies,
        onToggleFavorite: _toggleFavorite,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.movies,
    required this.onToggleFavorite,
  });

  final List<Map<String, dynamic>> movies;
  final ValueChanged<String> onToggleFavorite;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filteredMovies = widget.movies.where((movie) {
      final keyword = _query.toLowerCase();
      final title = (movie['title'] as String).toLowerCase();
      final genres = (movie['genres'] as List<String>)
          .any((genre) => genre.toLowerCase().contains(keyword));

      return title.contains(keyword) || genres;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Explorer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search by title or genre',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.08),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _MovieCard(
                    movie: movie,
                    onFavoritePressed: () =>
                        widget.onToggleFavorite(movie['id'] as String),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => MovieDetailScreen(
                            movie: movie,
                            onToggleFavorite: widget.onToggleFavorite,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    required this.movie,
    required this.onTap,
    required this.onFavoritePressed,
  });

  final Map<String, dynamic> movie;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final accentColor = movie['accentColor'] as Color;

    return Material(
      color: const Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: movie['id'] as String,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 92,
                    height: 132,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accentColor,
                          accentColor.withValues(alpha: 0.45),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      movie['posterIcon'] as IconData,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (movie['genres'] as List<String>).join(' • '),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber),
                        const SizedBox(width: 6),
                        Text(
                          (movie['rating'] as double).toStringAsFixed(1),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavoritePressed,
                icon: Icon(
                  (movie['isFavorite'] as bool)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: (movie['isFavorite'] as bool)
                      ? const Color(0xFFFF6B6B)
                      : Colors.white70,
                ),
                tooltip: 'Favorite',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.onToggleFavorite,
  });

  final Map<String, dynamic> movie;
  final ValueChanged<String> onToggleFavorite;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.movie['isFavorite'] as bool;
  }

  void _toggleFavorite() {
    widget.onToggleFavorite(widget.movie['id'] as String);
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.movie['accentColor'] as Color;
    final trailers = widget.movie['trailers'] as List<Map<String, String>>;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            title: Text(widget.movie['title'] as String),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: widget.movie['id'] as String,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            accentColor,
                            accentColor.withValues(alpha: 0.35),
                            const Color(0xFF111111),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.movie['posterIcon'] as IconData,
                          size: 124,
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0x66000000),
                          Color(0xFF111111),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie['title'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (widget.movie['genres'] as List<String>)
                                  .map(
                                    (genre) => Chip(
                                      label: Text(genre),
                                      backgroundColor:
                                          Colors.white.withValues(alpha: 0.10),
                                      side: BorderSide.none,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x1AF4A261),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0x66F4A261)),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber),
                            const SizedBox(height: 4),
                            Text(
                              (widget.movie['rating'] as double)
                                  .toStringAsFixed(1),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.movie['overview'] as String,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionChipButton(
                        icon:
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                        label: _isFavorite ? 'Saved' : 'Favorite',
                        onPressed: _toggleFavorite,
                      ),
                      _ActionChipButton(
                        icon: Icons.star_half_rounded,
                        label: 'Rate',
                        onPressed: () {},
                      ),
                      _ActionChipButton(
                        icon: Icons.ios_share_rounded,
                        label: 'Share',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Trailers',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    itemCount: trailers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final trailer = trailers[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE85D04),
                            child: Icon(Icons.play_arrow_rounded),
                          ),
                          title: Text(trailer['title']!),
                          subtitle: Text(trailer['duration']!),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChipButton extends StatelessWidget {
  const _ActionChipButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton.tonalIcon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        ),
      ),
    );
  }
}
