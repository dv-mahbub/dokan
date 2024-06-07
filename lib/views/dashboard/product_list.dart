import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/global_widget/custom_bottom_sheet.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:dokan/models/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String selectedFilter = '';
  List<ProductListModel>? productListModel;
  List<ProductListModel>? productList;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    String jsonString =
        await rootBundle.loadString('assets/json/response.json');
    List jsonData = jsonDecode(jsonString);
    if (mounted) {
      setState(() {
        productListModel = jsonData
            .map((json) =>
                ProductListModel.fromJson(json as Map<String, dynamic>))
            .toList();
        filterList();
      });
    }
  }

  void filterList() {
    setState(() {
      productList = productListModel;
      switch (selectedFilter) {
        case 'Newest':
          log('1');
          productListModel!
              .sort((a, b) => b.dateCreated!.compareTo(a.dateCreated!));
          break;
        case 'Oldest':
          log('2');
          productList!.sort((a, b) => a.dateCreated!.compareTo(b.dateCreated!));
          break;
        case 'Price low > High':
          log('3');
          productList!.sort((a, b) =>
              double.parse(a.price!).compareTo(double.parse(b.price!)));
          break;
        case 'Price high > Low':
          log('4');
          productList!.sort((a, b) =>
              double.parse(b.price!).compareTo(double.parse(a.price!)));
          break;
        case 'Best Selling':
          productList!.sort((a, b) => b.totalSales!.compareTo(a.totalSales!));
          break;
        default:
          productList = List.from(
              productListModel!); // Reset to original list if no filter is selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (productListModel != null) {
      filterList();
    }
    log(selectedFilter);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Gap(40),
                const Text(
                  'Product List',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  padding: const EdgeInsets.only(right: 25),
                  onPressed: () {},
                  icon: const SizedBox(
                    height: 25,
                    width: 25,
                    child: AppIcon(AppIcons.search),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showBottomSheet();
            },
            child: Container(
              width: .87.sw,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.whiteBg,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withOpacity(.1),
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Gap(15),
                  const AppIcon(
                    AppIcons.filter,
                    size: 20,
                  ),
                  const Gap(10),
                  Text(
                    'Filter',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyText),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Sort by',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyText),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.greyText,
                  ),
                  const Gap(15),
                  AppIcon(
                    AppIcons.hamburger,
                    size: 20,
                    color: AppColors.greyText,
                  ),
                  const Gap(15),
                ],
              ),
            ),
          ),
          const Gap(4),
          productList == null
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: .055.sw),
                          width: 1.sw,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...List.generate(
                                productList?.length ?? 0,
                                (index) => productContainer(index),
                              ),
                            ],
                          ),
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container productContainer(int index) {
    return Container(
      width: ScreenUtil().screenWidth < 600 ? .43.sw : .285.sw,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteBg,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: AppColors.shadowColor.withOpacity(.13),
            offset: const Offset(2, 3),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.red.shade100.withOpacity(.3),
              child: CachedNetworkImage(
                imageUrl: productList?[index].images?[0].src ?? '',
                placeholder: (context, String value) {
                  return const Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, String error, _) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    size: 55,
                  );
                },
                width: ScreenUtil().screenWidth < 600 ? .43.sw : .285.sw,
                height: ScreenUtil().screenWidth < 600 ? .48.sw : .33.sw,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    child: Text(
                      productList?[index].name ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: productList?[index].regularPrice != null &&
                            productList![index].regularPrice!.isNotEmpty &&
                            productList?[index].regularPrice !=
                                productList?[index].price,
                        child: Text(
                          '\$${productList?[index].regularPrice}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      const Gap(3),
                      Text(
                        '\$${productList?[index].price}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  selectedFilter == 'Best Selling'
                      ? Text(
                          '${productList?[index].totalSales ?? 0} sold',
                          style: const TextStyle(fontSize: 11),
                        )
                      : RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          itemSize: 17,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                  const Gap(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      // isDismissible: false,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          selectedFilter: selectedFilter,
          onChange: (newValue) {
            if (mounted) {
              setState(() {
                selectedFilter = newValue;
              });
              log(selectedFilter);
            }
          },
        );
      },
    );
  }
}
