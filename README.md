# India Demonetisation and Digital Payments

On November 8, 2016, the Indian government withdrew 86% of the currency in circulation overnight. Whatever you think of the policy, it generated some very interesting data.

## What's here

### The currency bounce-back (`demonetisation currency bounce back.Rmd`)

RBI publishes weekly data on "Notes Issued" (total currency in circulation). This notebook tracks how quickly currency came back into the system after demonetisation. The approach is simple - compute pre-demonetisation weekly growth rates, project them forward to get a "what if demonetisation hadn't happened" counterfactual, and compare against actual. The currency eventually caught up, but the growth rate changed - the system was adding cash faster than before, suggesting a regime change in cash usage patterns.

### Payment system evolution (`paymentStatPlay.Rmd`)

Bank-level monthly data from RBI on POS terminals, debit card transactions, credit card counts, and ATM usage. The plots show each bank's trajectory with a red vertical line at November 2016. Some banks saw permanent shifts in their digital payment volumes; others reverted to trend.

### Counterfactual analysis (`demonetisation impact.R`)

A more systematic version - takes the pre-demonetisation trend (average YoY growth from Nov 2014 to Oct 2016), projects it forward, and compares against actual values. Produces a multi-page PDF covering RTGS, NEFT, mobile banking, and card payments.

### RBI payment trends (`rbipaymentsdemon.R`)

Looks at credit card, debit card, and mobile wallet trends using linear models fitted to pre-demonetisation data (June 2012 to September 2016), then extrapolated forward as a visual counterfactual. The average transaction size plots are the most interesting - they reveal whether demonetisation changed who was using digital payments, not just how much.

### Supporting scripts

- `paymentsgraphs.R` - Publication-quality charts showing NEFT overtaking cheques, payment system share evolution
- `payments demonetisation.pdf` - A writeup on the payments data

## Data

Data files aren't included. The source is RBI's [Payment System Indicators](https://www.rbi.org.in/scripts/NEFTView.aspx) and the weekly statistical supplement for currency-in-circulation data.

## Dependencies

R, with `tidyverse`, `readxl`, `scales`.
