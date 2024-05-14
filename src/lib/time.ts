export const [periods, durations] = (() => {
	const millisecondsInSecond = 1000;
	const secondsInMinute = 60;
	const minutesInHour = 60;
	const hoursInDay = 24;

	const millisecond = 1;
	const second = millisecond * millisecondsInSecond;
	const minute = second * secondsInMinute;
	const hour = minute * minutesInHour;
	const day = hour * hoursInDay;

	return [
		{
			millisecond,
			second,
			minute,
			hour,
			day,
		},
		{
			millisecondsInSecond,
			secondsInMinute,
			minutesInHour,
			hoursInDay,
		},
	];
})();

function millisecondsUntil(target: Date) {
	return Math.max(target.getTime() - Date.now(), 0);
}

export type Unit = keyof typeof periods;

function millisecondsToUnit(milliseconds: number, unit: Unit) {
	return milliseconds / periods[unit];
}

export function parseTime(milliseconds: number): [number, Record<Unit, number>] {
	const toUnit = (unit: Unit) => millisecondsToUnit(milliseconds, unit);

	return [milliseconds, {
		millisecond: toUnit("millisecond") % durations.millisecondsInSecond,
		second: toUnit("second") % durations.secondsInMinute,
		minute: toUnit("minute") % durations.minutesInHour,
		hour: toUnit("hour") % durations.hoursInDay,
		day: toUnit("day"),
	}];
}

export function timeUntil(target: Date) {
	return parseTime(millisecondsUntil(target));
}

export const unitToSpanish: Record<Unit, string> = {
	millisecond: "milisegundo",
	second: "segundo",
	minute: "minuto",
	hour: "hora",
	day: "día",
};
