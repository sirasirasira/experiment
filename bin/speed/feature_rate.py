import numpy as np
import pandas  as pd

len_list = np.array([])
path = f"./feature"
with open(path) as f:
    for line in f:
        len_list = np.append(len_list, (len(line.split())-1) / 2)
len_df = pd.Series(len_list).astype(int)
len_df.value_counts(normalize=True).reindex(range(1, 11)).fillna(0).to_csv("feature_rate.dat", index=False)
