import { LightningElement, wire } from 'lwc';
import selectAll from '@salesforce/apex/RoundsContainerController.getRoundsJogadores';

export default class MeuRoundsContainer extends LightningElement {
    @wire(selectAll)
    listaDeRounds;

    get rounds() {
        return this.listaDeRounds.data;
    }
}