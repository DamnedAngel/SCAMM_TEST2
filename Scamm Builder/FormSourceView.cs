using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Scamm_Builder
{
    public partial class FormSourceView : Form
    {
        public bool Saved { get; private set; }
        public bool rogue = false;
        public bool ReadOnly
        {
            set
            {
                tbSource.ReadOnly = value;
            }
        }

        public FormSourceView()
        {
            InitializeComponent();
            Saved = false;
        }

        private void btCancel_Click(object sender, EventArgs e)
        {
            if (rogue)
            {
                Close();
            }
            else
            {
                Hide();
                DialogResult = DialogResult.Cancel;
            }
        }

        public string SourceText
        {
            get { return tbSource.Text; }
            set { tbSource.Text = value; }
        }

        private void FormSourceView_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (!rogue)
            {
                Hide();
                e.Cancel = true; // this cancels the close event.
            }
        }

        public static FormSourceView ShowDialog(string caption, string source, bool canSave)
        {
            using (var f = new FormSourceView())
            {
                f.Text = caption;
                f.SourceText = source;
                f.ReadOnly = false;
                f.btSave.Visible = canSave;
                f.ShowDialog();
                return f;
            }
        }

        public static void ShowRogue(string caption, string source)
        {
            var f = new FormSourceView();
            f.rogue = true;
            f.Text = caption;
            f.SourceText = source;
            f.Show();
        }

        private void btSave_Click(object sender, EventArgs e)
        {
            if (rogue)
            {
                Close();
            }
            else
            {
                Saved = true;
                DialogResult = DialogResult.OK;
            }
        }
    }
}
