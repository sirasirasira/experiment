import pandas as pd
from matplotlib import pyplot as plt

data_df = pd.read_csv("feature/feature_rate_summary.dat", sep="\t")
data_df = data_df.rename(columns={'naive': 'naive GTB'}).T
data_df.plot.bar(stacked=True);
plt.xlabel('#monte carlo simurations')
plt.ylabel('feature size rate')
plt.xticks(rotation=0)
plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left',fontsize=10,title='feature size')
plt.savefig("feature/feature_rate.eps", bbox_inches="tight")
