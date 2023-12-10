using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Scamm_Builder
{
    class SCAMMPicture : SCAMMNode
    {
        public new static string GetTypeName()
        {
            return "Picture";
        }

        public new static Type[] GetChildClasses()
        {
            return new Type[] { };
        }

        public SCAMMPicture()
        {
            Text = "Picture " + SequentialIndex;
        }

    }
}
