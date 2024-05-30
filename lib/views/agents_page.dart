import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsi_tpm/api/api_data_source.dart';
import 'package:responsi_tpm/models/agents_model.dart';
import 'package:responsi_tpm/views/agent_details_page.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agents',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: _buildListAgents(),
    );
  }

  Widget _buildListAgents() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadAgents(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            AgentsModel agentsModel = AgentsModel.fromJson(snapshot.data);
            return _buildSuccessSection(agentsModel);
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

  Widget _buildSuccessSection(AgentsModel data) {
    return ListView.builder(
      itemCount: data.data!.length,
      itemBuilder: (BuildContext context, index) {
        return _buildItem(data.data![index]);
      },
    );
  }

  Widget _buildItem(Data agentsData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentDetailsPage(uId: agentsData.uuid!),
          )),
      child: Card(
        color: Colors.red[50], // Set the card background to light red
        child: Row(
          children: [
            Container(
              width: 100,
              child: Image.network(agentsData.displayIcon!),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                agentsData.displayName! + " " + agentsData.developerName!,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
