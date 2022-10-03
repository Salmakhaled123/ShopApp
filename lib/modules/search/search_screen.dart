import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/components/components.dart';
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String ? value) {
                      if (value!.isEmpty) {
                        return 'enter text to search';
                      }
                    },
                    prefix: Icons.search,
                    label: 'Search',
                    onsubmit: (String? text)
                    {
                      SearchCubit.get(context).search(text: text);
                    }),
                SizedBox(
                  height: 10.0,
                ),
                if (state is SearchLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 10,),
                // Expanded(
                //   child:   ListView.separated(itemBuilder: (context,index)=>Row(
                //
                //     children: [
                //
                //       Image(
                //
                //         image:
                //
                //         NetworkImage('${model!.image}',
                //
                //         ),width: 100,height: 100,),
                //
                //
                //
                //       Expanded(
                //
                //         child: Padding(
                //
                //           padding: const EdgeInsets.all(20.0),
                //
                //           child: Column(
                //
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //
                //             children: [
                //
                //               Text('${model!.name}',
                //
                //                 style: TextStyle(fontSize: 18.0),
                //
                //                 overflow: TextOverflow.ellipsis,
                //
                //                 maxLines: 2,),
                //
                //               SizedBox(height: 15.0,),
                //
                //               Row(
                //
                //                 children: [
                //
                //                   Text('${model!.price}',style: TextStyle(fontSize: 16.0),),
                //
                //                   Spacer(),
                //
                //                   CircleAvatar(radius: 20.0,
                //
                //                     backgroundColor:
                //
                //                     ShopCubit.get(context).favourites[model!.id]! ? defaultColor:Colors.grey,
                //
                //                     child: IconButton(
                //
                //                         onPressed: ()
                //
                //                         {
                //
                //                           ShopCubit.get(context).changeFavorites(model!.id);
                //
                //
                //
                //                         },
                //
                //                         color: Colors.white,
                //
                //                         alignment: Alignment.topRight,
                //
                //
                //
                //                         icon: Icon(Icons.favorite_border,
                //
                //
                //
                //                         )),
                //
                //                   )
                //
                //                 ],
                //
                //               ),
                //
                //             ],),
                //
                //         ),
                //
                //       )
                //
                //     ],
                //
                //   ),
                //
                //       separatorBuilder: (context,index)=>Divider(),
                //
                //       itemCount: 10),
                // )
                if(state is SearchSuccessState)
              Expanded(
                child: ListView.separated(
             itemBuilder: (context,index)=> SearchProduct(SearchCubit.get(context).model!.data
                 !.data[index],context),
                    separatorBuilder: (context,index)=>Divider(),
                    itemCount:SearchCubit.get(context).model!.data!.data.length ),
              )

              ]),
            ),
          ),
        ),
      ),
    );
  }
}
