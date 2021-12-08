import { LightningElement, api } from 'lwc';

export default class MeuRoundContainer extends LightningElement {
    @api round;

    get premioTotal() {
        return this.formatarMoeda(this.round.PremioTotal__c);
    }

    get jogadores() {
        if (this.round) {
            return [ ...this.round.Jogadores__r.map((jogador) => {
                return {
                    ...jogador, valorDivida: "Valor Dívida: " + this.formatarMoeda(jogador.Candidato__r.ValorDivida__c) 
                }
            })];
        }
        return [];
    }

    formatarMoeda(valor) {
        if (valor) {
            return valor.toLocaleString('pt-br',{style: 'currency', currency: 'BRL'});
        }
        return '';
    }
}