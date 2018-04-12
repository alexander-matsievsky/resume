const fs = require('fs')
const resume = require('./resume.json')

function formatDates (object) {
  const format = new Intl.DateTimeFormat('en-US', { month: 'short', year: 'numeric' })
  if (object.startDate) { object.startDate = format.format(new Date(object.startDate)) }
  if (object.endDate) { object.endDate = format.format(new Date(object.endDate)) }
}

resume.education.forEach(formatDates)
resume.work.forEach(formatDates)
fs.writeFileSync('./resume.json', JSON.stringify(resume, null, 2))
