function formatDates (record) {
  const dateTimeFormat = new Intl.DateTimeFormat('en-US', { month: 'short', year: 'numeric' })
  if (record.startDate) { record._startDateFormatted = dateTimeFormat.format(new Date(record.startDate)) }
  if (record.endDate) { record._endDateFormatted = dateTimeFormat.format(new Date(record.endDate)) }
}

const resume = require('./resume.json')
resume.education.forEach(formatDates)
resume.work.forEach(formatDates)
require('fs').writeFileSync('./resume.json', `${JSON.stringify(resume, null, 2)}\n`)
