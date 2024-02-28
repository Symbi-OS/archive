make mybench_small
sudo ./mybench_small


mkdir new
sudo mv ~/../../mybench_small_*.csv ./new



ipython -c "%run combined.ipynb"
