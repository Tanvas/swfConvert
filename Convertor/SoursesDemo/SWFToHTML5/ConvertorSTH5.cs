using CommonConvertLib.Helpers;
using CommonConvertLib.StepMessager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5
{
    /// <summary>
    /// конвертор swf to html5
    /// </summary>
    public class ConvertorSTH5 : StepChangeMessager,IConvertor
    {
        /// <summary>
        /// параметры конвертации
        /// </summary>
        IConvertSettings settings;
        /// <summary>
        /// текущий swf файл
        /// </summary>
        string currentSWFPath;
        /// <summary>
        /// префикс временных файлов картинок
        /// </summary>
        string imgTmpPrefix = "tmpImg";
        /// <summary>
        /// путь к текущей временной
        /// папке
        /// </summary>
        string currentTmpImgPath;
        /// <summary>
        /// общая строка этапов конвертации
        /// </summary>
        string commonMesString;
        /// <summary>
        /// дополнительные параметры
        /// </summary>
        HTML5ConvertSettings specSet;
        /// <summary>
        /// текущая выходная директория
        /// </summary>
        string outPath="";
       
        /// <summary>
        /// конвертор swf to html5
        /// </summary>
        /// <param name="_settings">параметры конвертации</param>
        public ConvertorSTH5(IConvertSettings _settings)
        {
            if (_settings == null)
                throw new ArgumentNullException("_settings");

            
            settings = _settings;
        }
        /// <summary>
        /// загрузить swf файл
        /// </summary>
        /// <param name="pathToSwf">путь до файла</param>
        /// <exception cref="ArgumentNullException"></exception>
        /// <exception cref="Exception">ошибка файла</exception>
        public void SetInputSWF(string pathToSwf)
        {
            if (string.IsNullOrEmpty(pathToSwf))
                throw new ArgumentNullException("pathToSwf");
            commonMesString = "\nКонвертация файла " + pathToSwf;
                     
            currentSWFPath = pathToSwf;            
            SetSpecSetting();
           
        }
        /// <summary>
        /// установить параметры
        /// для конкретных конверторов
        /// </summary>
        private void SetSpecSetting()
        {
            specSet = new HTML5ConvertSettings(settings);
            specSet.ImgTmpPrefix = imgTmpPrefix;
            specSet.SWFPath = currentSWFPath;
            currentTmpImgPath = settings.TmpDirectory.AsPath() + specSet.FileNameWithoutExtension;
            specSet.TmpImgPath = currentTmpImgPath.AsPath();
        }
      
        /// <summary>
        /// конвертировать
        /// </summary>
        /// <param name="outPath">выходная директория</param>
        /// <returns></returns>
        public void Convert(string _outPath)
        {
            if (string.IsNullOrEmpty(_outPath))
                throw new ArgumentNullException("_outPath");

            this.outPath = _outPath.AsPath();

            try
            { 
                CheckParams();

                Prepare();

                int frameCount=System.IO.Directory.GetFiles(specSet.TmpImgPath.AsPath(), "*.jpg", System.IO.SearchOption.TopDirectoryOnly).Length;

                if(frameCount>1)
                {
                    Convert2MP4();
                    Convert2Webm();
                }
                
                Finally();
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
           
        }
        /// <summary>
        /// проверить параметры перед конвертацией
        /// </summary>
        private void CheckParams()
        {
            if (!System.IO.File.Exists(specSet.AbsMP4EXE))
                throw new Exception("Для конвертации необходим файл: " + specSet.AbsMP4EXE);

            if (!System.IO.File.Exists(specSet.AbsWEBMEXE))
                throw new Exception("Для конвертации необходим файл: " + specSet.AbsWEBMEXE);
        }

        

        /// <summary>
        /// подготовка к конвертации
        /// </summary>
        void Prepare()
        {
            SendMessage(commonMesString + "\nПодготовка к конвертации");
                
            DirectoryHelper.CreateDirectory(specSet.TmpImgPath.AsPath(), true);

            Convertor2Image ci = new Convertor2Image(specSet);
            string d = specSet.TmpImgPath.AsPath();
            ci.Convert(specSet.TmpImgPath.AsPath());
           
        }

        void Convert2MP4()
        {
            SendMessage("\nКонвертация в формат .mp4");

            Convertor2Mp4 mp = new Convertor2Mp4(specSet);

            try
            { 
                mp.Convert(outPath);
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
            
        }

        void Convert2Webm()
        {
            SendMessage("\nКонвертация в формат .webm");

            Convertor2Webm wm = new Convertor2Webm(specSet);
            try
            {
                wm.Convert(outPath);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// завершающее действие при
        /// конвертации
        /// </summary>
        /// <returns>успешность выполнения</returns>
        void Finally()
        {
            SendMessage("\nЗавершение процесса конвертации видео");
            try 
            { 
                MoveFirstImage();
                ClearTmpFolder();
                DeleteOriginal();
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
           

        }

        /// <summary>
        /// удалить оригинал
        /// </summary>
        private void DeleteOriginal()
        {
            if (!settings.IsOrigDel)
                return;
            try
            { 
                System.IO.File.Delete(currentSWFPath);
                
            }
            catch(Exception )
            {
                SendMessage("\n!!!!! Не удалось удалить файл "+currentSWFPath); 
                
            }
        }

        /// <summary>
        /// очистить временную директорию
        /// </summary>
        private void ClearTmpFolder()
        {
            try
            {
                DirectoryHelper.ClearDirectory(settings.TmpDirectory.AsPath()); 
            }
            catch
            {
                ///ОШИБКУ ПРИ УДАЛЕНИИ ИЗ ВРЕМЕННОЙ ПАПКИ ИГНОРИРОВАТЬ!!!!
            }
        }

        /// <summary>
        /// копировать первый кадр
        /// </summary>
        private void MoveFirstImage()
        {
            string imgFirst = System.IO.Directory.GetFiles(specSet.TmpImgPath.AsPath(), "*.jpg", System.IO.SearchOption.TopDirectoryOnly).First<string>();
            string newImgPath = outPath.AsPath() + specSet.FileNameWithoutExtension + ".jpg";
            try
            {
                  
                System.IO.File.Copy(imgFirst, newImgPath, false);
                
            }
            catch 
            {  
                if(!System.IO.File.Exists(newImgPath))
                    SendMessage("\n!!!!! Не удалось создать файл-постер " + newImgPath);
            }
        }
       
    }
}
