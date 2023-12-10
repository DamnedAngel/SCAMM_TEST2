using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Scamm_Builder 
{
    class SCAMMGameTab : SCAMMNodeTab
    {
        public SCAMMGameTab(TabControl tabControl, SCAMMNode node, string text) : base(tabControl, node, text)
        {
            ASMTemplateName = "GameStructure.s";
        }
    }
}
