using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

    public class Exceptions
    {

        public class ValidationException : Exception
        {
            public ValidationException(string message)
               : base(message)
            {
            }
        }
    }
