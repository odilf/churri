// Maybe this is a bit overkill but it's to make typescript happy
const allDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] as const;
const allDigitsString: string[] = [...allDigits];

export type Digit = (typeof allDigits)[number];

function parseDigit(digit: string): Digit {
	if (digit.length > 1 || !allDigitsString.includes(digit)) {
		throw new Error(`Given value is not a digit (it's ${digit})`);
	}

	return digit as Digit;
}

export function digits(number: number): Digit[] {
	return number.toString().split("").map(parseDigit);
}
