export const [periods, durations] = (() => {
	const millisecondsInSecond = 1000;
	const secondsInMinute = 60;
	const minutesInHour = 60;
	const hoursInDay = 24;
	const daysInWeek = 7;

	const millisecond = 1;
	const second = millisecond * millisecondsInSecond;
	const minute = second * secondsInMinute;
	const hour = minute * minutesInHour;
	const day = hour * hoursInDay;
	const week = day * daysInWeek;

	return [
		{
			millisecond,
			second,
			minute,
			hour,
			day,
			week,
		},
		{
			millisecondsInSecond,
			secondsInMinute,
			minutesInHour,
			hoursInDay,
			daysInWeek,
		}
	];
})()

function millisecondsUntil(target: Date) {
	return Math.max(
		target.getTime() - Date.now(),
		0,
	);
}

type Unit = keyof typeof periods;

function millisecondsToUnit(milliseconds: number, unit: Unit) {
	return milliseconds / periods[unit];
}

export function parseTime(milliseconds: number) {
	const toUnit = (unit: Unit) => millisecondsToUnit(milliseconds, unit);

	return {
		seconds: toUnit('second') % durations.secondsInMinute,
		minutes: toUnit('minute') % durations.minutesInHour,
		hours: toUnit('hour') % durations.hoursInDay,
		days: toUnit('day') % durations.daysInWeek,
		weeks: toUnit('week')
	};
}

export function timeUntil(target: Date) {
	return parseTime(millisecondsUntil(target));
}
