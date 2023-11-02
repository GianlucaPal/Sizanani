using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace SizananiTecnicalAssessment.Models
{
    public class Helpers
    {

        private static string Key = "hdlggotjslfbnghtukmnsoshtjsgfytj";
        private static string IV = "galdbtrksnlouvsh";
        public static string Encrypt(string text)
        {
            byte[] plainTextBytes = System.Text.ASCIIEncoding.ASCII.GetBytes(text);
            AesCryptoServiceProvider aes = new AesCryptoServiceProvider();
            aes.BlockSize = 128;
            aes.KeySize = 256;
            aes.Key = System.Text.ASCIIEncoding.ASCII.GetBytes(Key);
            aes.IV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV);
            aes.Padding = PaddingMode.PKCS7;
            aes.Mode = CipherMode.ECB;
            ICryptoTransform crypto = aes.CreateEncryptor(aes.Key, aes.IV);

            byte[] encrypted = crypto.TransformFinalBlock(plainTextBytes, 0, plainTextBytes.Length);
            crypto.Dispose();
            return Convert.ToBase64String(encrypted);
        }

        public static string Decrypt(string encrypted)
        {
            encrypted = encrypted.Replace(" ", "+");
            byte[] encryptedBytes = Convert.FromBase64String(encrypted);
            AesCryptoServiceProvider aes = new AesCryptoServiceProvider();
            aes.BlockSize = 128;
            aes.KeySize = 256;
            aes.Key = System.Text.ASCIIEncoding.ASCII.GetBytes(Key);
            aes.IV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV);
            aes.Padding = PaddingMode.PKCS7;
            aes.Mode = CipherMode.ECB;
            ICryptoTransform crypto = aes.CreateDecryptor(aes.Key, aes.IV);
            byte[] secret = crypto.TransformFinalBlock(encryptedBytes, 0, encryptedBytes.Length);
            return System.Text.ASCIIEncoding.ASCII.GetString(secret);

        }
    }
}