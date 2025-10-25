import '../../components/export_files.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        Navigator.pushNamed(
          context,
          RecipeDetailScreen.routeName,
          arguments: RecipeDetailScreen(recipe: recipe),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageWidget(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _recipeNameWidget(),
              const SizedBox(height: 6),
              _estimateMinute(),
            ],
          ),
        ],
      ),
    );
  }

  Text _recipeNameWidget() {
    return Text(
      recipe.title?.toUpperCase() ?? 'UNKNOWN RECIPE',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
        color: Color(0xFF22615A), // teal-like title color
      ),
    );
  }

  Stack _imageWidget() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              recipe.image ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, size: 40),
              ),
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: InkWell(
            onTap: onFavoriteToggle,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.redAccent : Colors.grey.shade400,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _estimateMinute() {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          recipe.readyInMinutes != null
              ? '${recipe.readyInMinutes} mins'
              : '— mins',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
