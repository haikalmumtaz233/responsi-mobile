import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsi_tpm/api/api_data_source.dart';
import 'package:responsi_tpm/models/maps_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Future<void> _launchedUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maps',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: _buildListMaps(),
    );
  }

  Widget _buildListMaps() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMaps(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MapsModel mapsModel = MapsModel.fromJson(snapshot.data);
            return _buildSuccessSection(mapsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(child: Text("Error"));
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MapsModel data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: data.data!.length,
      itemBuilder: (BuildContext context, index) {
        return _buildItem(data.data![index]);
      },
    );
  }

  Widget _buildItem(Data mapsData) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _launchedUrl(mapsData.displayIcon!);
        },
        child: Card(
          color: Colors.red[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                    mapsData.splash!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  mapsData.displayName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis, // Prevent overflow
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  mapsData.coordinates ??
                      "null", // Display "null" if coordinates are null
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis, // Prevent overflow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
