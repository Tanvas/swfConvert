using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5
{
    /// <summary>
    /// параметры конвертации html5
    /// </summary>
    internal class HTML5ConvertSettings
    {
        /// <summary>
        /// максимальное количество попыток
        /// конвертации
        /// </summary>
        public readonly int MaxCountTrying = 3;
        /// <summary>
        /// общие настройки
        /// </summary>
        public IConvertSettings commonSet { get; private set; }
        /// <summary>
        /// абсолютный путь к 
        /// исполнительному файлу 
        /// конвертации в формат mp4
        /// </summary>
        public readonly string AbsMP4EXE;
        /// <summary>
        /// абсолютный путь к 
        /// исполнительному файлу 
        /// конвертации в формат webm
        /// </summary>
        public readonly string AbsWEBMEXE;
        /// <summary>
        /// путь к swf файлу
        /// </summary>
        string swfPth;
        /// <summary>
        /// путь к swf файлу
        /// </summary>
        public string SWFPath
        {
            get
            {
                return swfPth;
            }
            set
            {
                if (value == null)
                    throw new ArgumentNullException("SWFPath");
                swfPth = value;
                FileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(swfPth);
            }
        }
        /// <summary>
        /// имя файла
        /// </summary>
        public string FileNameWithoutExtension { get; private set; }
        /// <summary>
        /// путь к временной папке 
        /// с картинками
        /// </summary>
        public string TmpImgPath;
        /// <summary>
        /// префикс временных файлов картинок
        /// </summary>
        public string ImgTmpPrefix;
        /// <summary>
        /// конвертор swf to html5
        /// </summary>
        /// <param name="_settings">параметры конвертации</param>
        public HTML5ConvertSettings(IConvertSettings _settings)
        {
            if (_settings == null)
                throw new ArgumentNullException("_settings");

            commonSet = _settings;

            string path=System.IO.Path.GetDirectoryName(this.GetType().Module.FullyQualifiedName).AsPath();
            string convertorsPath = System.IO.Path.Combine(path, "utils").AsPath();
            AbsMP4EXE = System.IO.Path.Combine(convertorsPath, "ffmpeg.exe");
            AbsWEBMEXE = System.IO.Path.Combine(convertorsPath, "ffmpeg-webm.exe");
            
        }
    }
}
