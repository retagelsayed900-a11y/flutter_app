import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project/home/cubit/cubit/home_cubit.dart';


import '../model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Banners Section
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeBannersErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to load banners')),
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                if (state is HomeBannersLoadingState) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
               
                    ),
                  );
                }
               
                return CarouselSlider(
                  items: [
                    for (var banner in cubit.bannerModel.data ?? [])
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(banner.image ?? ''),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  ],
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Popular Pack',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle "See All" button press
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Products Section
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeProductsErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to load products')),
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                List<Products>? products = cubit.productModel.data?.products;
                
             
                
                return SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 195,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  products?[index].image ?? '',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              products?[index].name ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                products?[index].description ?? '',
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    '\$${products?[index].price ?? 0}',
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                FloatingActionButton(
                                  heroTag: 'product_$index',
                                  mini: true,
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.green,
                                  onPressed: () {
                                    // Handle add to cart button press
                                  },
                                  child: const Icon(Icons.add, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      leading: const Icon(Icons.menu),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Row(
          children: const [
            Icon(Icons.pin_drop),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                      color: Colors.green,
                    ),
                  ],
                ),
                Text(
                  '123 Main St, City, Country',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle search action
          },
        ),
      ],
    );
  }
}

