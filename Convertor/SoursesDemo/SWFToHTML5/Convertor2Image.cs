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
    /// конвертор в формат jpg
    /// </summary>
    internal class Convertor2Image : OperateExecuter,IConvertor
    {
       
        /// <summary>
        /// параметры конвертации 
        /// </summary>
        HTML5ConvertSettings settings;
        /// <summary>
        /// префикс к временным файлам
        /// изображений кадров
        /// </summary>
        readonly string  imgTmpPrefix;
        
        /// <summary>
        /// текущая попытка конвертации
        /// </summary>
        int currentTrying = 0;
        
        /// <summary>
        /// конвертор swf to jpg
        /// </summary>
        /// <param name="_settings">параметры конвертации</param>
        public Convertor2Image(HTML5ConvertSettings _settings)
        {
            if (_settings == null)
                throw new ArgumentNullException("_settings");
            
            settings = _settings;
            imgTmpPrefix = settings.ImgTmpPrefix;
            maxTrying = settings.MaxCountTrying;
        }
        /// <summary>
        /// конвертировать
        /// </summary>
        /// <param name="outPath">выходная директория</param>
        /// <returns></returns>
        public void Convert(string outPath)
        {
            currentTrying++;
            try
            {

                outPath = outPath.AsPath();

                IConvertSettings cmnSt = settings.commonSet;
                SWFToImage.SWFToImageObject obj = new SWFToImage.SWFToImageObject();
                obj.InitLibrary("demo", "demo");
                obj.JPEGQuality = sbyte.Parse(cmnSt.Quality.ToString());
                obj.InputSWFFileName = settings.SWFPath;
                obj.FrameIndex = 0;
                obj.ImageOutputType = SWFToImage.TImageOutputType.iotJPG;

                string fileName = settings.ImgTmpPrefix;
                obj.ImageWidth = cmnSt.WidthPx;
                obj.ImageHeight = cmnSt.HeightPx;

                DoOperation(obj.Execute_Begin, "запуск конвертации");               

                int frCount = obj.FramesCount;
                for (int i = 0; i < frCount; i++)
                {
                    obj.FrameIndex = i;
                
                    DoOperation(obj.Execute_GetImage, "получение изображения"); 
                    fileName = GetTmpImgFileName(i);

                    string imgPath=outPath + fileName + ".jpg";

                    DoOperation(obj.SaveToFile, imgPath, "сохранение изображения"); 
                }

                DoOperation(obj.Execute_End,"завершение конвертации");
               
            }
            catch (Exception ex)
            {
                throw new Exception("Ошибка конвертации файла " + settings.FileNameWithoutExtension + ".swf в набор изображений: " + ex.Message);
            }
        }

        /// <summary>
        /// получить имя временного файла
        /// картинки кадра
        /// </summary>
        /// <param name="num">номер кадра</param>       
        /// <returns>имя картинки</returns>
        private string GetTmpImgFileName(int num)
        {
            
            if (num < 10)
                return imgTmpPrefix + "000" + num.ToString();
            if (num < 100)
                return imgTmpPrefix + "00" + num.ToString();
            if (num < 1000)
                return imgTmpPrefix + "0" + num.ToString();
            if (num < 10000)
                return imgTmpPrefix + num.ToString();

            throw new Exception("Слишком большой видео-файл " + settings.SWFPath);
        }
        public void SetInputSWF(string pathToSwf)
        {
            throw new NotImplementedException();
        }

        
    }
}
