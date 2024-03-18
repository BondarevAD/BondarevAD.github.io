import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:wff_job/pages/job_page/job_page.dart';
import 'package:wff_job/pages/tabs/saved_list_job/saved_list_cubit.dart';
import 'package:wff_job/pages/tabs/saved_list_job/saved_list_state.dart';
import 'package:wff_job/utils/extension/build_extension.dart';
import 'package:wff_job/widgets/job_card.dart';

class SavedListScreen extends StatelessWidget {
  const SavedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SavedListCubit, SavedListState>(
        builder: (context, state) {
          if (state is SavedListEmpty) {
            return Center(
              child: Text(context.localization.noSavedJobs),
            );
          } else if (state is SavedListInitial) {
            var savedJobs = state.savedJobs;
            return ListView.builder(
              itemCount: savedJobs.length,
              itemBuilder: (context, index) {
                final job = savedJobs[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(JobPage(
                      job: job,
                      isSaved: BlocProvider.of<SavedListCubit>(context)
                          .isInSavedList(job),
                      onPressed: () => BlocProvider.of<SavedListCubit>(context)
                          .addToSavedList(job),
                    ));
                  },
                  child: JobCard(
                    job: job,
                    isSaved: true,
                    onSaveButtonClick: () =>
                        BlocProvider.of<SavedListCubit>(context)
                            .deleteFromSavedList(job),
                  ),
                );
              },
            );
          } else if (state is SavedListUpdated) {
            var savedJobs = state.savedJobs;
            return ListView.builder(
              itemCount: savedJobs.length,
              itemBuilder: (context, index) {
                final job = savedJobs[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(JobPage(
                      job: job,
                      isSaved: BlocProvider.of<SavedListCubit>(context)
                          .isInSavedList(job),
                      onPressed: () => BlocProvider.of<SavedListCubit>(context)
                          .addToSavedList(job),
                    ));
                  },
                  child: JobCard(
                    job: job,
                    isSaved: true,
                    onSaveButtonClick: () =>
                        BlocProvider.of<SavedListCubit>(context)
                            .deleteFromSavedList(job),
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
