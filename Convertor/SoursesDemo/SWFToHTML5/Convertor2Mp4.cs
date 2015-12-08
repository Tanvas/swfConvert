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
    /// конвертор в формат mp4
    /// </summary>
    internal class Convertor2Mp4 : OperateExecuter,IConvertor
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
        public Convertor2Mp4(HTML5ConvertSettings _settings)
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
                currOutFile = outPath + settings.FileNameWithoutExtension + ".mp4";

                DoOperation(DoConvert, "конвертация в формат mp4");         


               
            }
            catch (Exception ex)
            {
                throw new Exception("Ошибка конвертации файла " + settings.FileNameWithoutExtension + ".mp4: " + ex.Message);
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
            string path = settings.AbsMP4EXE;
            startInfo.FileName = path;
            startInfo.CreateNoWindow = true;
            startInfo.UseShellExecute = false;
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardInput = true;
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;
            string argStr = GetArgumentString();
            startInfo.Arguments = argStr;

            _process.StartInfo = startInfo;

            DoOperation(_process.Start, "Запуск процесса");
                     
            _process.WaitForExit();
            _process.Close();
            /*ffmpeg -f image2 -if img/tmpImg%3d.jpg -vcodec libx264 -threads 0 -r 25 -g 50 -b 500k -y out.mp4
            */
             
            return System.IO.File.Exists(currOutFile);
        }
        /// <summary>
        /// получить строку аргументов
        /// </summary>
        /// <returns></returns>
        private string GetArgumentString()
        {

            string args = @"-f image2 -i " +  settings.TmpImgPath + settings.ImgTmpPrefix + @"%4d.jpg";
            args += @" -vcodec libx264 -threads 0 -r 25 -g 50 -b 500k -y ";
            args+=currOutFile;

            return args;
        }
        public void SetInputSWF(string pathToSwf)
        {
            throw new NotImplementedException();
        }
    }
}
