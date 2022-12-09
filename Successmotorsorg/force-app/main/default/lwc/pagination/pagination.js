import { api, LightningElement, track } from "lwc";


export default class pagination extends LightningElement {
    /* @api pagedata = [];
    @api title = "";
    @track currentPageIndex = 0;
    @track maxNumberOfPages = 0;
    // later, we might make this a configurable property
    // hard-coding for now
    MAX_PAGES_TO_SHOW = 3;

    @api
    get currentlyShown() {
        // just your run-of-the-mill pagination edge cases
        const potentialPageStartingRange =
            this.MAX_PAGES_TO_SHOW * this.currentPageIndex >= this.pagedata.length ?
            this.pagedata.length - this.MAX_PAGES_TO_SHOW :
            this.MAX_PAGES_TO_SHOW * this.currentPageIndex;
        const potentialPageEndingRange =
            this.currentPageIndex === 0 ?
            this.MAX_PAGES_TO_SHOW :
            potentialPageStartingRange + this.MAX_PAGES_TO_SHOW;

        return this.pagedata.slice(
            potentialPageStartingRange,
            potentialPageEndingRange
        );
    }

    renderedCallback() {
        this.maxNumberOfPages = !!this.pagedata ?
            this.pagedata.length / this.MAX_PAGES_TO_SHOW :
            0;
        this.dispatchEvent(new CustomEvent("pagerchanged"));
    }

    // in pager.js
    handlePrevious() {
        this.currentPageIndex =
            this.currentPageIndex > 0 ? this.currentPageIndex - 1 : 0;
        this.dispatchEvent(new CustomEvent("pagerchanged"));
    }

    handleNext() {
        this.currentPageIndex =
            this.currentPageIndex < this.maxNumberOfPages ?
            this.currentPageIndex + 1 :
            this.maxNumberOfPages;
        this.dispatchEvent(new CustomEvent("pagerchanged"));
    }
}*/
    @api
    get currentlyShown() {
        // just your run-of-the-mill pagination edge cases
        const potentialPageStartingRange =
            this.MAX_PAGES_TO_SHOW * this.currentPageIndex >= this.pagedata.length ?
            this.pagedata.length - this.MAX_PAGES_TO_SHOW :
            this.MAX_PAGES_TO_SHOW * this.currentPageIndex;
        const potentialPageEndingRange =
            this.currentPageIndex === 0 ?
            this.MAX_PAGES_TO_SHOW :
            potentialPageStartingRange + this.MAX_PAGES_TO_SHOW;

        return this.pagedata.slice(
            potentialPageStartingRange,
            potentialPageEndingRange
        );
    }

    renderedCallback() {
        this.maxNumberOfPages = !!this.pagedata ?
            this.pagedata.length / this.MAX_PAGES_TO_SHOW :
            0;
        this.dispatchEvent(new CustomEvent("pagerchanged"));
    }
}