import 'package:app/model/Contato.dart';
import 'package:app/util/status.dart';
import 'package:app/view/LoginView.dart';
import 'package:app/viewmodel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (_, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text("HOME"),
              actions: [
                IconButton(
                  onPressed: () {
                    viewmodel.logout().then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    });
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: _buildBody(viewmodel),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {

                  

              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    final status = viewModel.status;

    if (status is Carregando) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 10),
            Text(status.message),
          ],
        ),
      );
    } else if (status is Success) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        physics:
            BouncingScrollPhysics(), // Desativa a rolagem interna do ListView
        itemCount: status.value.length,
        itemBuilder:
            (_, i) => ListTile(
              onTap: () {
                //viewModel.share(status.value[i]);
              },
              title: Row(
                spacing: 10,
                children: [
                  CircleAvatar(
                    radius: 30,
                    foregroundImage: NetworkImage("${status.value[i].foto}"),
                    // Image.network(
                    //   "${status.value[i].foto}",
                    //   height: 100,
                    //   width: 100,
                    //   errorBuilder:
                    //       (context, error, stackTrace) => Container(
                    //         color: Colors.black,
                    //         width: 50,
                    //         height: 50,
                    //       ),
                    // ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${status.value[i].nome}"),
                      Text("${status.value[i].telefone}"),
                      Divider(color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
      );
    } else if (status is Erro) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 40),
            SizedBox(height: 10),
            Text("Erro: $status"),
          ],
        ),
      );
    } else {
      return Text("Pressione o botão para carregar os dados.");
    }
  }
}
