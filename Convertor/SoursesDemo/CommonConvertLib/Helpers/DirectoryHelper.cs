
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;


namespace CommonConvertLib.Helpers
{
    /// <summary>
    /// класс для манипуляций с директориями
    /// </summary>
    public class DirectoryHelper
    {
        /// <summary>
        /// создать директорию
        /// 
        /// </summary>
        /// <param name="_path">путь для создания</param>
        /// <param name="_isExistDel">true - пересоздать созданную директорию (с удалением файлов)</param>
        /// <exception cref="ArgumentNullException"></exception>
        /// <exception cref="AppException">Ошибка создания директории</exception>
        /// 
        public static bool CreateDirectory(string _path, bool _isExistDel)
        {
            if(string.IsNullOrEmpty(_path))
                throw new ArgumentNullException("Невозможно создать папку, не задан путь");

            try
            {
                if (Directory.Exists(_path) && _isExistDel)
                    ClearDirectory(_path);
                
                if(!Directory.Exists(_path))
                { 
                    Directory.CreateDirectory(_path);
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                
                throw new Exception("Ошибка создания директории: " + _path + ". " + ex.Message);
            }
        }
        /// <summary>
        /// удалить директорию       
        /// </summary>
        /// <param name="_path">директория для удаления</param>       
        /// <exception cref="ArgumentNullException"></exception>
        /// <exception cref="AppException">Ошибка удаления директории</exception>
        /// 
        public static bool DeleteDirectory(string _path)
        {
            if (string.IsNullOrEmpty(_path))
                throw new Exception("Не указана папка для удаления");
            try
            {
                if (Directory.Exists(_path))
                    Directory.Delete(_path, true);

                return true;
            }
            catch(Exception ex)
            {
                throw new Exception("Ошибка удаления директории: " + _path + ". " + ex.Message);
            }

        }


        /// <summary>
        /// очистить папку от данных
        /// </summary>
        /// <param name="_path"></param>
        public static void ClearDirectory(string _path)
        {
            if (string.IsNullOrEmpty(_path))
                throw new Exception("Не указана папка для очистки");
            try
            {
                foreach (string dir in Directory.GetDirectories(_path))
                    Directory.Delete(Path.Combine(_path, dir), true);

                foreach (string currFile in Directory.GetFiles(_path))
                    File.Delete(Path.Combine(_path, currFile));
            }
            catch (Exception ex)
            {
                throw new Exception("Ошибка очистки директории: " + _path + ". " + ex.Message);
            }
        }

        /// <summary>
        /// копирование необходимых файлов
        /// </summary>
        /// <param name="_from">из дериктории</param>
        /// <param name="_to">конечная директория</param>
        public static void CopyFiles(DirectoryInfo _from, DirectoryInfo _to)
        {
            try
            { 
                CopyFilesOnly(_from, _to);
                foreach (DirectoryInfo di in _from.GetDirectories())
                {
                    string dirName = di.Name;

                    string newDir = Path.Combine(_to.FullName, dirName);
                    DirectoryHelper.CreateDirectory(newDir, true);
                    DirectoryInfo newDirect = new DirectoryInfo(newDir);

                    CopyFiles(di, newDirect);
                }

            }
            catch(Exception ex)
            {
                throw new Exception("Ошибка копирования директории: " + _from + ". " + ex.Message);
            }

        }
        /// <summary>
        /// копирование только файлов
        /// </summary>
        /// <param name="_from">источник</param>
        /// <param name="_to">конечная директория</param>
        private static void CopyFilesOnly(DirectoryInfo _from, DirectoryInfo _to)
        {
            try
            {
                foreach (FileInfo fi in _from.GetFiles())
                {
                    string fileName = fi.Name;
                    string newFile = Path.Combine(_to.FullName, fileName);
                    File.Copy(fi.FullName, newFile, true);
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Ошибка копирования файла: " + _from + ". " + ex.Message);
            }
        }
    }
}
