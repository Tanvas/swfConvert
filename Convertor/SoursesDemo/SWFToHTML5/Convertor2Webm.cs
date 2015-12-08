using SWFToHTML5.Helpers;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5
{
    /// <summary>
    /// конвертор в формат webm
    /// </summary>
    internal class Convertor2Webm : OperateExecuter,IConvertor
    {
       
        /// <summary>
        /// параметры конвертации
        /// </summary>
        HTML5ConvertSettings settings;
        /// <summary>
        /// путь создаваемого файла
        /// </summary>
        string currOutFile;
              
        /// <summary>
        /// конвертор swf to html5
        /// </summary>
        /// <param name="_settings">параметры конвертации</param>
        public Convertor2Webm(HTML5ConvertSettings _settings)
        {
            if (_settings == null)
                throw new ArgumentNullException("_settings");

            settings = _settings;
            maxTrying = settings.MaxCountTrying;
        }
       
        /// <summary>
        /// конвертировать
        /// </summary>
        /// <param name="outPath">выходная директория</param>
        /// <returns></returns>
        public void Convert(string outPath)
        {
            try
            {
                currOutFile = outPath + settings.FileNameWithoutExtension + ".webm";

                DoOperation(DoConvert, "конвертация в формат webm");               
               
            }
            catch (Exception ex)
            {
                throw new Exception("Ошибка конвертации файла " + settings.FileNameWithoutExtension + ".webm: " + ex.Message);
            }
        }
        /// <summary>
        /// выполнить конвертацию
        /// </summary>
        /// <returns>создание файла</returns>
        bool DoConvert()
        {

            Process _process = new Process();
            ProcessStartInfo startInfo = new ProcessStartInfo();
            string path = settings.AbsWEBMEXE;
            startInfo.FileName = path;
            startInfo.CreateNoWindow = true;
            startInfo.UseShellExecute = false;
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardInput = true;
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;
            string argStr = GetArgumentString();
            startInfo.Arguments = argStr;

            _process.StartInfo = startInfo;

            DoOperation(_process.Start, "запуск процесса конвертации");

            _process.WaitForExit();
            _process.Close();

            return System.IO.File.Exists(currOutFile);
        }
        /// <summary>
        /// получить строку аргументов
        /// </summary>
        /// <returns></returns>
        private string GetArgumentString()
        {
           
            string args = @"-f image2 -i " + settings.TmpImgPath + settings.ImgTmpPrefix + @"%4d.jpg";
            args += @" -threads 0 -r 25 -g 50 -b 500k -y ";
            args += currOutFile;

            return args;
        }
        public void SetInputSWF(string pathToSwf)
        {
            throw new NotImplementedException();
        }
    }
}
