import 'package:flutter/material.dart';
import '../../model/repo.dart';

class RepoItem extends StatelessWidget {
  final Repo repo;
  RepoItem(this.repo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(repo.id.toString()),
      leading: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/placeholder.jpg',
          image: repo.owner.avatar,
          width: 55.0,
          height: 55.0,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
        ),
      ),
      title: Text(repo.owner.name),
      subtitle: Text(repo.name),
      trailing: IconButton(
        icon: Icon(Icons.star_border_outlined),
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('You tapped ${repo.name}!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
