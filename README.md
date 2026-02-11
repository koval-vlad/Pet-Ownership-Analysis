---
title: Pet Ownership Analysis
emoji: 🐱
colorFrom: blue
colorTo: green
sdk: docker
pinned: false
---

# Pet Ownership Statistics — Jupyter Notebook Dashboard

![Pet Ownership Dashboard](https://koval-vlad-portfolio.vercel.app/images/pet_dashboard_presentation/Slide11.webp)

Interactive dashboard analyzing U.S. pet ownership by state: cats vs dogs, households, populations, and ownership density. Built in Jupyter with **Panel**, **Plotly**, **Matplotlib**, and **Tabulator**.

## Live Demo

**[View Live Dashboard →](https://koval-vlad-portfolio.vercel.app/python/pet-analysis-dashboard)**

---

## Technologies & Libraries

| Category | Technology |
|----------|------------|
| **Runtime** | Python 3, Jupyter Notebook |
| **Data** | `pandas`, `numpy`, `openpyxl` (Excel) |
| **Dashboard UI** | **Panel** (HoloViz) — `FastListTemplate`, `Tabs`, `Row` |
| **Interactive tables** | **Tabulator** (via `pn.extension('tabulator')`) — `pn.widgets.Tabulator` |
| **Charts (interactive)** | **Plotly** (`plotly.express`) — `pn.extension('plotly')`, `pn.pane.Plotly` |
| **Charts (static)** | **Matplotlib**, **Seaborn** — `pn.pane.Matplotlib` |
| **Special charts** | **PyWaffle** — waffle charts |

---

## Chart Types

| Chart | Library | Description |
|-------|---------|-------------|
| **Radar (polar line)** | Plotly `px.line_polar` | Top 20 Cat/Dog mean population by state |
| **Bubble** | Plotly `px.scatter` | Top 20 cat population states (circle layout, size = population) |
| **Waffle** | PyWaffle | Top 20 dog population states (grid of colored cells) |
| **Radial bar** | Matplotlib polar `ax.bar` | Top 20 cat/dog owning households by state |
| **Dumbbell** | Matplotlib `hlines` + `scatter` | Cat vs dog ownership % (🐱 vs 🐶) by state |
| **Pie** | Matplotlib `plt.pie` | Top 20 pet density states (with explode) |
| **Circular bar (polar)** | Matplotlib `ax.barh` (polar) | Top 20 pet households; Top 20 total households |

---

## Tabulator

- **Widget**: `pn.widgets.Tabulator` with full dataset + computed **Total / Avg** row.
- **Features**: Frozen header row (`frozen_rows=[0]`), frozen `location` column, column sort, number formatters (thousands separator, 0 or 1 decimal), tooltips, row styling for the total row.
- **Layout**: `layout='fit_data'`, `height=650`, no pagination for in-notebook use.

---

## Project Structure (Files Diagram)

```
Presentation/
├── README.md                          # This file (Hugging Face metadata + docs)
├── requirements.txt                   # Python dependencies
├── Dockerfile                         # Docker image for running dashboard
├── .dockerignore                      # Docker build exclusions
├── catsvdogs.xlsx                     # Source data (households, pets by state)
├── pet_ownership_analysis.ipynb      # Jupyter dashboard (DataManager, ChartManager, DashboardManager)
└── Pet_Ownership_Analysis_presentation.pptx   # Slide deck
```

**Notebook structure (conceptual):**

```
pet_ownership_analysis.ipynb
├── Imports (numpy, pandas, matplotlib, seaborn, pywaffle, plotly, panel + tabulator/plotly extensions)
├── DataManager          → load_data() from catsvdogs.xlsx, organize_data() (column renames)
├── ChartManager         → create_* methods for each chart + create_data_tabulator_table()
├── DashboardManager     → cache_data(), create_dashboard_tabs(), show_dashboard() (FastListTemplate)
├── (Optional) cell      → test individual charts
└── Run dashboard        → DataManager() → DashboardManager() → show_dashboard(inline=True)
```

---

## Getting Started

1. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```
2. **Run the notebook**
   - Open `pet_ownership_analysis.ipynb` in Jupyter and run all cells, or 
   - Use the **Docker** setup (see `Dockerfile`) to run the dashboard in a container.
3. **View dashboard**
   - The last cell displays the Panel dashboard inline (tabs: Pet Data, Pet Households, Pet Ownership Density, Pet Population, Pet Ownership, Pet Mean Population).

---

## Data Source

- **File**: `catsvdogs.xlsx`
- **Content**: U.S. state-level metrics — locations, household counts, pet ownership %, dog/cat households and populations, mean dogs/cats per household.

---

## License & Credits

For more projects and the live demo, see the portfolio: [koval-vlad-portfolio.vercel.app](https://koval-vlad-portfolio.vercel.app/python/pet-analysis-dashboard).
