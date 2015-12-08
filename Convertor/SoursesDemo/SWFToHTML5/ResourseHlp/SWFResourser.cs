using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace SWFToHTML5.ResourseHlp
{

    /// <summary>
    /// класс-помощник для получения
    /// swf ресурсов из указанной 
    /// директории
    /// </summary>
    public class SWFResourser:IResourse
    {
         /// <summary>
        /// корневая директория данных
        /// </summary>
        readonly string  rootDirectory;
        /// <summary>
        /// список файлов ресурсов
        /// </summary>
        IList<string> swfRes;

        public SWFResourser(string _rootDir)
        {
            if (string.IsNullOrEmpty(_rootDir))
                throw new ArgumentNullException("_rootDir");

            if (!Directory.Exists(_rootDir))
                throw new Exception("Корневая директория данных отсутствует.");

            rootDirectory = _rootDir;

            InitResurses();

        }

        /// <summary>
        /// инициализировать ресурсы
        /// </summary>
        private void InitResurses()
        {
           swfRes= Directory.GetFiles(rootDirectory, "*.swf", SearchOption.AllDirectories);
        }

        /// <summary>
        /// реализация интерфейса перечисления
        /// </summary>
        /// <returns></returns>
        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return swfRes.GetEnumerator();
        }

        public bool IsCorrect
        {
            get { return swfRes != null; }
        }
    }
}
