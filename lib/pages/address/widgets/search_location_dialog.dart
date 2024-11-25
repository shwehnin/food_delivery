import 'package:flutter/material.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationDialog extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchLocationDialog({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      // alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.width20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Container(
            child: Text("Google map search"),
          ),
          // child: Container(
          //   child:
          //       TypeAheadField(builder: (context, searchController, focusNode) {
          //     return TextField(
          //       controller: _controller,
          //       focusNode: focusNode,
          //       textInputAction: TextInputAction.search,
          //       autofocus: true,
          //       textCapitalization: TextCapitalization.words,
          //       keyboardType: TextInputType.streetAddress,
          //       decoration: InputDecoration(
          //         hintText: "Search Location",
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(
          //             Dimensions.width10,
          //           ),
          //           borderSide: const BorderSide(
          //             style: BorderStyle.none,
          //             width: 0,
          //           ),
          //         ),
          //         hintStyle: Theme.of(context)
          //             .textTheme
          //             .headlineMedium
          //             ?.copyWith(
          //               color: Theme.of(context).textTheme.bodyMedium?.color,
          //               fontSize: Dimensions.font16,
          //             ),
          //       ),
          //     );
          //   }, itemBuilder: (context, Prediction suggestion
          //           // Prediction suggestion
          //           ) {
          //     return Padding(
          //       padding: EdgeInsets.all(Dimensions.width10),
          //       child: Row(
          //         children: [
          //           Icon(Icons.location_on),
          //           Expanded(
          //             child: Text(
          //               // 'heelo',
          //               suggestion.description!,
          //               maxLines: 1,
          //               overflow: TextOverflow.ellipsis,
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .headlineMedium
          //                   ?.copyWith(
          //                     color:
          //                         Theme.of(context).textTheme.bodyMedium?.color,
          //                     fontSize: Dimensions.font16,
          //                   ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   }, onSelected: (Prediction suggestion
          //           // Prediction suggestion
          //           ) {
          //     Get.find<LocationController>().setLocation(
          //         suggestion.placeId!, suggestion.description!, mapController);
          //     Get.back();
          //   }, suggestionsCallback: (pattern) async {
          //     return await Get.find<LocationController>()
          //         .searchLocation(context, pattern);
          //   }),
          // ),
        ),
      ),
    );
  }
}
