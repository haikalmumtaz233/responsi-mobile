import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsi_tpm/api/api_data_source.dart';
import 'package:responsi_tpm/models/agent_details_model.dart';

class AgentDetailsPage extends StatelessWidget {
  final String uId;
  const AgentDetailsPage({super.key, required this.uId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: _buildAppBarTitle(),
      ),
      body: _buildAgentDetails(uId),
    );
  }

  Widget _buildAppBarTitle() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadAgentDetails(uId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (snapshot.hasData) {
          AgentDetails agentDetails = AgentDetails.fromJson(snapshot.data);
          return Text(
            agentDetails.data!.displayName! +
                " " +
                agentDetails.data!.developerName!,
            style: TextStyle(color: Colors.white),
          );
        }
        return Text('Agent Details', style: TextStyle(color: Colors.white));
      },
    );
  }

  Widget _buildAgentDetails(String uId) {
    return FutureBuilder(
      future: ApiDataSource.instance.loadAgentDetails(uId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        }
        if (snapshot.hasData) {
          AgentDetails agentDetails = AgentDetails.fromJson(snapshot.data);
          return _buildSuccessSection(agentDetails);
        }
        return _buildErrorSection();
      },
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

  Widget _buildSuccessSection(AgentDetails agentDetails) {
    Data data = agentDetails.data!;
    List<Abilities>? abilities = data.abilities;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(data.fullPortrait!, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    data.displayName! + " " + data.developerName!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Role: ${data.role?.displayName ?? 'N/A'}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "${data.description ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Abilities: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 8),
                if (abilities != null)
                  Row(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: abilities.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) {
                            Abilities ability = abilities[index];
                            return Card(
                              color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      ability.displayIcon!,
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      ability.displayName!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
