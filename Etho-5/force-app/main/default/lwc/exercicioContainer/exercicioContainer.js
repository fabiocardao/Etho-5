import { LightningElement } from 'lwc';

export default class ExercicioContainer extends LightningElement {

    valorDefault = "";

    get roundsEmAndamento() {
        return [
            {label: "Selecione um Round para iniciar", value: ""},
        ];
    }
}