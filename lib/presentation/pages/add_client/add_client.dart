import 'package:distribucion_app/domain/entities/client.dart';
import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:distribucion_app/presentation/pages/add_client/widgets/client_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:uuid/uuid.dart';

class AddClient extends StatelessWidget {
  const AddClient({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    final cBloc = context.read<ClientBloc>();

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildForm(formKey),
            const SizedBox(height: 16),
            _buildSaveButton(formKey, cBloc),
            const ClientList(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(GlobalKey<FormBuilderState> formKey) {
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: FormBuilderValidators.required(
                errorText: 'Este campo es requerido'),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'code',
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Código'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Este campo es requerido'),
              FormBuilderValidators.numeric(
                  errorText: 'Este campo debe ser numérico'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(
    GlobalKey<FormBuilderState> formKey,
    ClientBloc cBloc,
  ) {
    return TextButton(
      onPressed: () {
        if (formKey.currentState!.saveAndValidate()) {
          final formData = formKey.currentState!.value;

          final newClient = Client(
            idClient: const Uuid().v4(),
            name: formData['name'],
            code: int.parse(formData['code']),
          );

          cBloc.add(AddOneClient(client: newClient));
          formKey.currentState!.reset();
        }
      },
      child: const Text('Guardar'),
    );
  }
}
