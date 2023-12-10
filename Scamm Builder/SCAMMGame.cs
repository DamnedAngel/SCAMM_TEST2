using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Scamm_Builder
{
    class SCAMMGame : SCAMMNode
    {
        public new static string GetTypeName()
        {
            return "Game";
        }

        public new static Type[] GetChildClasses()
        {
            return new Type[] { typeof(SCAMMContext), typeof(SCAMMObject), typeof(SCAMMPicture) };
        }

        public SCAMMGame (TabControl tabControl)
        {
            Text = "SCAMM Game";
            tab = new SCAMMGameTab(tabControl, this, Text);
            tab.ResetGrid(Text);
        }
    }
}
