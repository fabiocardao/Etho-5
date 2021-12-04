import { LightningElement, wire } from 'lwc';
import selectAll from '@salesforce/apex/RoundsContainerController.getRoundsJogadores';

export default class RoundsContainer extends LightningElement {
    @wire(selectAll)
    listaDeRounds;

    get rounds() {
        return this.listaDeRounds.data;
    }
}