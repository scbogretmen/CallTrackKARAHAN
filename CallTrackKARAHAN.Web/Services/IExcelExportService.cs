using CallTrackKARAHAN.Web.Models;

namespace CallTrackKARAHAN.Web.Services;

public interface IExcelExportService
{
    byte[] ExportCallLogsToExcel(IEnumerable<CallLog> logs);
}
