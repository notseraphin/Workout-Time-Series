import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WEEKLY_CSV = os.path.join(BASE_DIR, "../results/weekly_volume.csv")
RESULTS_TXT = os.path.join(BASE_DIR, "../results/results.txt")
FIG_DIR = os.path.join(BASE_DIR, "../figures")
os.makedirs(FIG_DIR, exist_ok=True)


sns.set_style("whitegrid")


def parse_results_txt(file_path):
    """
    Parses the results.txt file containing two tables:
    1. Muscle progression (avg delta 1RM)
    2. Average weekly volume per muscle
    Returns two DataFrames: exercise_prog_df, weekly_avg_df
    """
    with open(file_path, "r") as f:
        lines = [line.strip() for line in f.readlines() if line.strip()]

    # Find table boundaries
    table_starts = [i for i, line in enumerate(lines) if line.startswith("muscle_group")]
    if len(table_starts) < 2:
        raise ValueError("Expected two tables in results.txt")

    # --- Table 1: Muscle progression ---
    table1_lines = lines[table_starts[0]:table_starts[1]-1]  # exclude next header
    headers1 = [h.strip() for h in table1_lines[0].split("|")]
    rows1 = []
    for line in table1_lines[2:]:  # skip header and separator
        parts = [x.strip() for x in line.split("|")]
        if len(parts) == len(headers1):
            rows1.append(parts)
    exercise_prog_df = pd.DataFrame(rows1, columns=headers1)
    # Convert numeric columns
    numeric_cols1 = ["num_exercises", "avg_delta_1rm", "total_delta_1rm"]
    for col in numeric_cols1:
        exercise_prog_df[col] = pd.to_numeric(exercise_prog_df[col], errors='coerce')

    # --- Table 2: Weekly averages ---
    table2_lines = lines[table_starts[1]:]
    headers2 = [h.strip() for h in table2_lines[0].split("|")]
    rows2 = []
    for line in table2_lines[2:]:  # skip header and separator
        parts = [x.strip() for x in line.split("|")]
        if len(parts) == len(headers2):
            rows2.append(parts)
    weekly_avg_df = pd.DataFrame(rows2, columns=headers2)
    numeric_cols2 = ["avg_sets_per_week", "avg_reps_per_week"]
    for col in numeric_cols2:
        weekly_avg_df[col] = pd.to_numeric(weekly_avg_df[col], errors='coerce')

    return exercise_prog_df, weekly_avg_df

# --- Load data ---
weekly_df = pd.read_csv(WEEKLY_CSV)
exercise_prog_df, weekly_avg_df = parse_results_txt(RESULTS_TXT)

# ---------------- Plot functions ----------------

def plot_weekly_volume_heatmap(df):
    pivot = df.pivot_table(
        index=['year', 'week'],
        columns='muscle_group',
        values='total_sets',
        aggfunc='sum',
        fill_value=0
    )
    plt.figure(figsize=(12,6))
    sns.heatmap(pivot.T, cmap="YlGnBu", linewidths=.5)
    plt.title("Weekly Total Sets per Muscle Group")
    plt.xlabel("Week (Year-Week)")
    plt.ylabel("Muscle Group")
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "weekly_volume_heatmap.png"))
    plt.close()
    print("Saved: weekly_volume_heatmap.png")

def plot_weekly_volume_trend(df):
    grouped = df.groupby(['year','week','muscle_group'])['total_reps'].sum().reset_index()
    grouped['year_week'] = grouped['year'].astype(str) + '-' + grouped['week'].astype(str)
    plt.figure(figsize=(14,6))
    sns.lineplot(data=grouped, x='year_week', y='total_reps', hue='muscle_group', marker='o')
    plt.xticks(rotation=45)
    plt.title("Weekly Total Reps per Muscle Group Over Time")
    plt.xlabel("Year-Week")
    plt.ylabel("Total Reps")
    plt.legend(title="Muscle Group")
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "weekly_reps_trend.png"))
    plt.close()
    print("Saved: weekly_reps_trend.png")

def plot_exercise_1rm_progression(df):
    if df.empty:
        print("Skipping 1RM progression plots (exercise_prog_df empty).")
        return
    exercises = df['muscle_group'].unique()
    plt.figure(figsize=(12,6))
    for ex in exercises:
        subset = df[df['muscle_group'] == ex]
        plt.plot(subset.index, subset['avg_delta_1rm'], marker='o', label=ex)
    plt.xticks(rotation=45)
    plt.title("Average Δ1RM Progression per Muscle Group")
    plt.xlabel("Workout Index")
    plt.ylabel("Average Δ1RM")
    plt.legend(bbox_to_anchor=(1.05,1), loc='upper left')
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "exercise_1rm_progression.png"))
    plt.close()
    print("Saved: exercise_1rm_progression.png")

def plot_muscle_group_delta(df):
    if df.empty:
        print("Skipping muscle delta plots.")
        return
    plt.figure(figsize=(10,6))
    sns.barplot(data=df, x='muscle_group', y='avg_delta_1rm', palette='viridis')
    plt.title("Average Δ1RM per Muscle Group")
    plt.xlabel("Muscle Group")
    plt.ylabel("Average Δ1RM")
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "avg_delta_1rm_per_muscle.png"))
    plt.close()
    print("Saved: avg_delta_1rm_per_muscle.png")

def plot_weekly_avg_sets(df):
    plt.figure(figsize=(10,6))
    sns.barplot(data=df, x='muscle_group', y='avg_sets_per_week', palette='coolwarm')
    plt.title("Average Weekly Sets per Muscle Group")
    plt.xlabel("Muscle Group")
    plt.ylabel("Average Sets per Week")
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "avg_weekly_sets_per_muscle.png"))
    plt.close()
    print("Saved: avg_weekly_sets_per_muscle.png")

def plot_weekly_avg_reps(df):
    plt.figure(figsize=(10,6))
    sns.barplot(data=df, x='muscle_group', y='avg_reps_per_week', palette='magma')
    plt.title("Average Weekly Reps per Muscle Group")
    plt.xlabel("Muscle Group")
    plt.ylabel("Average Reps per Week")
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "avg_weekly_reps_per_muscle.png"))
    plt.close()
    print("Saved: avg_weekly_reps_per_muscle.png")

def plot_delta_vs_weekly_reps(ex_prog_df, weekly_avg_df):
    # Merge by muscle_group
    merged = pd.merge(ex_prog_df, weekly_avg_df, on='muscle_group')
    plt.figure(figsize=(10,6))
    sns.scatterplot(data=merged, x='avg_reps_per_week', y='avg_delta_1rm', hue='muscle_group', s=100)
    plt.title("Average Δ1RM vs Average Weekly Reps per Muscle Group")
    plt.xlabel("Average Weekly Reps")
    plt.ylabel("Average Δ1RM")
    plt.legend(title="Muscle Group", bbox_to_anchor=(1.05,1))
    plt.tight_layout()
    plt.savefig(os.path.join(FIG_DIR, "delta_vs_weekly_reps.png"))
    plt.close()
    print("Saved: delta_vs_weekly_reps.png")

# ---------------- Run all plots ----------------
if __name__ == "__main__":
    plot_weekly_volume_heatmap(weekly_df)
    plot_weekly_volume_trend(weekly_df)
    plot_exercise_1rm_progression(exercise_prog_df)
    plot_muscle_group_delta(exercise_prog_df)
    plot_weekly_avg_sets(weekly_avg_df)
    plot_weekly_avg_reps(weekly_avg_df)
    plot_delta_vs_weekly_reps(exercise_prog_df, weekly_avg_df)
