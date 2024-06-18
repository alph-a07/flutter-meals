import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({required this.onSelectMeal, required this.meal, super.key});

  final Meal meal;
  final void Function() onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: onSelectMeal,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          meal.title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MealItemTrait(
                                icon: Icons.schedule,
                                label: '${meal.duration} min'),
                            MealItemTrait(
                                icon: Icons.soup_kitchen_outlined,
                                label: complexityText),
                            MealItemTrait(
                                icon: Icons.currency_rupee_rounded,
                                label: affordabilityText),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
