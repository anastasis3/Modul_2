import { LightningElement, track, wire } from 'lwc';
import getProductRecords from '@salesforce/apex/productListController.getProductRecords'
export default class Productlist extends LightningElement {
    @track items = []; //this will hold key, value pair
    @track value = ''; //initialize combo box value
    @track chosenValue = '';

    @wire(getProductRecords)
    wiredRecords({ error, data }) {
        if (data) {

            //create array with elements which has been retrieved controller
            //here value will be record Id and label of combobox will be Name of record
            for (i = 0; i < data.length; i++) {
                this.items = [...this.items, { value: data[i].Id, label: data[i].Name }];
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;

        }
    }

    get recordOptions() {
        return this.items;
    }

    handleChange(event) {
        // Get the string of the "value" attribute on the selected option
        const selectedOption = event.detail.value;
        console.log('selected value=' + selectedOption);
        this.chosenValue = selectedOption;
    }

    //this value will be shown as selected value of combobox item
    get selectedValue() {
        return this.chosenValue;
    }
}