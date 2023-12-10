using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Scamm_Builder
{
    class SCAMMNodeTab : TabPage
    {
        private DataGridViewTextBoxColumn cVariable;
        private DataGridViewTextBoxColumn cDescription;
        private DataGridViewTextBoxColumn cSize;
        private DataGridViewTextBoxColumn cType;
        private DataGridViewTextBoxColumn cData;
        private DataGridView grid;

        public IDictionary<String, ScammVariable> nodeVars;

        protected string ASMTemplateName = null;

        public SCAMMNode SCAMMNode { get; protected set; }
        public TabControl TabControl { get; protected set; }

        protected string spacer = "        ";   // Spacer for X button

        private bool reactToCellChange = false;

        protected bool IsCurrentRowNameVar()
        {
            if (grid.CurrentRow != null)
            {
                return ScammVariable.IsNameVar(grid.CurrentRow.Cells["cVariable"].Value.ToString());
            }
            return false;
        }

        public void SetText(string text)
        {
            Text = text + spacer;
        }
        public string NodeName { get { return Name; } set { SetText (Name = value); } }

        private void LoadGridFromVars(string varNameValue)
        {
            grid.Rows.Clear();
            reactToCellChange = false;
            foreach (var gameVar in nodeVars.Values)
            {
                //string value = gameVar.value;
                if (gameVar.IsNameVar())
                {
                    if (varNameValue != null)
                    {
                        gameVar.value = varNameValue;
                    }
                    NodeName = gameVar.value;
                }
                grid.Rows.Add(gameVar.name, gameVar.description, gameVar.size, ScammVariableType.typeNames[gameVar.varType], gameVar.varType ==
                    ScammVariableType.svt_pEventHandler ? "<code...>" : gameVar.value);
                grid.EndEdit();
                grid.Rows[this.grid.Rows.Count - 1].Visible = (gameVar.usage == ScammVariableUsage.svu_editable);
            }
            reactToCellChange = true;
        }

        public void ResetGrid(string VarNameValue)
        {
            ScammVariable.Reset(ref nodeVars, SCAMMUtil.getTextResource(ASMTemplateName));
            LoadGridFromVars(VarNameValue);
        }

        public virtual void SaveGrid(BinaryWriter bw)
        {
            int numVars = grid.Rows.GetRowCount(DataGridViewElementStates.Visible);
            bw.Write(numVars);
            foreach (var gameVar in nodeVars.Values)
            {
                if (gameVar.usage == ScammVariableUsage.svu_editable)
                {
                    bw.Write(gameVar.name);
                    bw.Write(gameVar.value);
                }
            }
        }

        public virtual void LoadGrid(BinaryReader br)
        {
            ResetGrid(null);

            int varCount = br.ReadInt32();
            for (int i = 0; i < varCount; i++)
            {
                var varName = br.ReadString();
                try
                {
                    var gameVar = nodeVars[varName];
                    gameVar.value = br.ReadString();
                }
                catch (Exception excpt)
                {
                    MessageBox.Show("The following Exception ocurred loading variable " + i.ToString() + "/" + varCount.ToString() + " (" + varName + ") of a " + this.GetType() + ": " + excpt.Message);
                    throw new SCAMMException();
                }
            }

            LoadGridFromVars(null);
        }

        public SCAMMNodeTab() { }

        public SCAMMNodeTab(TabControl tabControl, SCAMMNode node, string name)
        {
            this.TabControl = tabControl;
            SCAMMNode = node;
            NodeName = name;
            reactToCellChange = false;
            InitializeComponent();
            foreach (DataGridViewColumn column in this.grid.Columns)
            {
                column.SortMode = DataGridViewColumnSortMode.NotSortable;
            }
            this.grid.Parent = this;
            reactToCellChange = true;
        }

        public void ShowTab()
        {
            grid.Size = new System.Drawing.Size(Size.Width - 12, Size.Height - 12);
            if (this.TabControl != null)
            {
                if (!this.TabControl.TabPages.Contains(this))
                {
                    this.TabControl.TabPages.Add(this);
                }
                this.TabControl.SelectedTab = this;
            }
        }

        public void HideTab()
        {
            if (this.TabControl != null)
            {
                this.TabControl.TabPages.Remove(this);
            }
        }

        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.grid = new System.Windows.Forms.DataGridView();
            this.cVariable = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cDescription = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cSize = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cType = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cData = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.grid)).BeginInit();
            this.SuspendLayout();
            // 
            // grid
            // 
            this.grid.AllowUserToAddRows = false;
            this.grid.AllowUserToDeleteRows = false;
            this.grid.AllowUserToResizeRows = false;
            this.grid.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.grid.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.grid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.cVariable,
            this.cDescription,
            this.cSize,
            this.cType,
            this.cData});
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.grid.DefaultCellStyle = dataGridViewCellStyle2;
            this.grid.Location = new System.Drawing.Point(6, 6);
            this.grid.Name = "grid";
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.grid.RowHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.grid.Size = new System.Drawing.Size(915, 469);
            this.grid.TabIndex = 1;
            this.grid.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.grid_CellDoubleClick);
            this.grid.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.grid_CellValueChanged);
            // 
            // cVariable
            // 
            this.cVariable.HeaderText = "Variable";
            this.cVariable.Name = "cVariable";
            this.cVariable.ReadOnly = true;
            this.cVariable.Width = 180;
            // 
            // cDescription
            // 
            this.cDescription.HeaderText = "Description";
            this.cDescription.Name = "cDescription";
            this.cDescription.ReadOnly = true;
            this.cDescription.Width = 290;
            // 
            // cSize
            // 
            this.cSize.HeaderText = "Size";
            this.cSize.Name = "cSize";
            this.cSize.ReadOnly = true;
            this.cSize.Width = 40;
            // 
            // cType
            // 
            this.cType.HeaderText = "Type";
            this.cType.Name = "cType";
            this.cType.ReadOnly = true;
            // 
            // cData
            // 
            this.cData.HeaderText = "Data";
            this.cData.Name = "cData";
            this.cData.Width = 242;
            ((System.ComponentModel.ISupportInitialize)(this.grid)).EndInit();
            this.ResumeLayout(false);

        }

        private void grid_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            var type = grid.CurrentRow.Cells["cType"].Value.ToString();
            grid.ReadOnly = (type.CompareTo(ScammVariableType.typeNames[ScammVariableType.svt_pEventHandler]) == 0);
        }

        private void grid_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            var type = grid.CurrentRow.Cells["cType"].Value.ToString();
            if (type.CompareTo(ScammVariableType.typeNames[ScammVariableType.svt_pEventHandler]) == 0)
            {
                var name = grid.CurrentRow.Cells["cVariable"].Value.ToString();
                var gameVar = nodeVars[name];

                FormSourceView f = FormSourceView.ShowDialog("Game." + name, gameVar.value, true);
                if (f.Saved)
                {
                    gameVar.value = f.SourceText;
                }
                f.Close();
            }
            else if (type.CompareTo(ScammVariableType.typeNames[ScammVariableType.svt_pObjectList]) == 0)
            {
                var name = grid.CurrentRow.Cells["cVariable"].Value.ToString();
                var gameVar = nodeVars[name];

                FormSourceView f = FormSourceView.ShowDialog("Game." + name, gameVar.value, true);
                if (f.Saved)
                {
                    gameVar.value = f.SourceText;
                }
                f.Close();
            }
        }

        private void grid_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            if (reactToCellChange)
            {
                var gameVar = nodeVars[grid.CurrentRow.Cells["cVariable"].Value.ToString()];
                object val = grid.CurrentRow.Cells["cData"].Value;
                gameVar.value = val != null ? val.ToString() : "";
                if (ScammVariable.IsNameVar(gameVar.name))
                {
                    NodeName = SCAMMNode.Text = gameVar.value;
                }
            }
        }
    }
}
