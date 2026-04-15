const cds = require('@sap/cds')

class ProcessorService extends cds.ApplicationService {
  /** Registering custom event handlers */
  init() {
    // Validamos fechas en CREATE y UPDATE
    this.before(['CREATE', 'UPDATE'], "Incidents", (req) => this.validarFechas(req));
    
    this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
    this.before("CREATE", "Incidents", (req) => this.changeUrgencyDueToSubject(req.data));

    return super.init();
  }

  /** Nueva validación de fechas */
  validarFechas(req) {
    const { creationDate, resolutionDate } = req.data;

    // Solo validamos si el usuario envió ambas fechas
    if (creationDate && resolutionDate) {
      const creacion = new Date(creationDate);
      const resolucion = new Date(resolutionDate);

      if (resolucion <= creacion) {
        // Usamos req.error para que SAP Fiori lo muestre correctamente
        req.error(400, "La fecha de resolución debe ser posterior a la fecha de creación.", "resolutionDate");
      }
    }
  }

  changeUrgencyDueToSubject(data) {
    let urgent = data.title?.match(/urgent/i)
    if (urgent) data.urgency_code = 'H'
  }

  /** Custom Validation */
  async onUpdate (req) {
    let closed = await SELECT.one(1).from(req.subject).where`status.code = 'C'`
    if (closed) req.reject`Can't modify a closed incident!`
    console.log('Validación de cierre ejecutada')
  }
}

module.exports = { ProcessorService }