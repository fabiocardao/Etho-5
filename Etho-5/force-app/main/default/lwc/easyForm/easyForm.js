import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EasyForm extends LightningElement {

    filtro = "";

    contatos = [
        {Id: 1, Name: "Renato", Sobrenome__c: "De Vico"},
        {Id: 2, Name: "Maria Sophia", Sobrenome__c: "De Vico"},
        {Id: 3, Name: "Arthur", Sobrenome__c: "Groissmann"}
    ];

    filtrarContatos(sobrenome) {
        return this.contatos.filter((contato) => contato.Sobrenome__c == this.filtro);
    }

    get contatosFiltrados() {
        return this.filtrarContatos();
    }

    handleChange(event) {
        this.filtro = event.target.value;
    }

    get registroImpressoBonitinho() {
        if (this.registro && this.registro.Nome__c) {
            return JSON.stringify(this.registro);
        }
        return '';
    }

    salvar(event) {
        if (this.formularioValido()) {
            this.showToast('Sucesso!', this.registro, 'success', 'sticky');
        } else {
            this.showToast('Erro!', JSON.stringify(this.registro), 'error', 'sticky');
        }
    }

    formularioValido() {
        const allValid = [
            ...this.template.querySelectorAll('lightning-input')
        ].reduce((validSoFar, inputCmp) => {
            return validSoFar && inputCmp.checkValidity();
        }, true);

        return allValid;
    }

    showToast(title, message, variant, mode) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(event);
    }

}