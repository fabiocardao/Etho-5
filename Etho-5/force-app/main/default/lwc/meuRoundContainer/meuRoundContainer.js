import { LightningElement, api } from 'lwc';

export default class MeuRoundContainer extends LightningElement {
    @api round;

    dinheiro = 10;

    get formatarMoeda() {
        return this.round.PremioTotal__c.toLocaleString('pt-br',{style: 'currency', currency: 'BRL'});
    }
}