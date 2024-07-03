import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:real_estate_app/components/custom_search_bar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showPopup(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context)?.insert(_overlayEntry!);
    _controller.forward();
  }

  void _hidePopup() {
    _controller.reverse().then((_) {
      _overlayEntry?.remove();
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100.0,
        left: 16.0,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: _scaleAnimation,
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Locate Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Find Other Locations.\nSample Current Location.'),
                  SizedBox(height: 10),
                  TextButton(
                    child: Text('Close'),
                    onPressed: _hidePopup,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSmallPopups() {
    return [
      Positioned(
        bottom: 200.0,
        left: 50.0,
        child: _smallPopup(),
      ),
      Positioned(
        bottom: 300.0,
        left: 100.0,
        child: _smallPopup(),
      ),
      Positioned(
        bottom: 400.0,
        left: 150.0,
        child: _smallPopup(),
      ),
    ];
  }

  Widget _smallPopup() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Container(
          width: 30 + (_scaleAnimation.value * 30),
          height: 30,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          mapShow(),
          ..._buildSmallPopups(),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: CustomSearchBar(),
          ),
          Positioned(
            bottom: 120.0,
            left: 16.0,
            child: FloatingActionButton(
              onPressed: () => _showPopup(context),
              child: Icon(Icons.info),
            ),
          ),
        ],
      ),
    );
  }

  Widget mapShow() {
    return FlutterLocationPicker(
      showCurrentLocationPointer: false,
      showSearchBar: false,
      showSelectLocationButton: false,
      showLocationController: false,
      showZoomController: false,
      initZoom: 11,
      minZoomLevel: 5,
      maxZoomLevel: 16,
      trackMyPosition: false,
      searchBarBackgroundColor: Colors.white,
      selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
      mapLanguage: 'en',
      onError: (e) => print(e),
      onPicked: (pickedData) {
        print(pickedData.latLong.latitude);
        print(pickedData.latLong.longitude);
        print(pickedData.address);
        print(pickedData.addressData);
      },
      onChanged: (pickedData) {
        print(pickedData.latLong.latitude);
        print(pickedData.latLong.longitude);
        print(pickedData.address);
        print(pickedData.addressData);
      },
      showContributorBadgeForOSM: true,
    );
  }
}
