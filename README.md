# CDV-A Algorithm: Automated Crossover Detection for MF-DFA

This repository provides the implementation of the CDV-A (Crossover Detection based on Variances of slope differences) algorithm, a novel approach for automatically detecting crossovers in fluctuation functions derived from Multi-Fractal Detrended Fluctuation Analysis (MF-DFA). 

## About the Algorithm

The CDV-A algorithm automates the detection of crossovers, which are critical points in time series analysis where the scaling behavior changes, revealing distinct correlation regimes. Traditional methods rely on manual identification, which can be subjective, time-consuming, and prone to error. CDV-A eliminates these challenges by using mathematical optimization of slope difference variances to objectively and efficiently identify crossover locations.

## Key Features

- **Automated Crossover Detection**: Reduces reliance on manual expert assessment, improving reproducibility and efficiency.
- **Robust Against Noise**: Validated on synthetic datasets with varying levels of noise, demonstrating high accuracy in diverse scenarios.
- **Applicable to Real-World Data**: Successfully tested on real fluctuation functions from fields such as finance, biology, and physics.
- **Integrates with MF-DFA**: Designed to seamlessly work within existing MF-DFA workflows.

## Validation and Performance

The CDV-A algorithm was tested on:
- **Synthetic Datasets**: Controlled mono-fractal and multi-fractal fluctuation functions with known crossover locations, under different noise levels. Results show high accuracy, especially under low-noise conditions.
- **Real-World Datasets**: Applied to fluctuation functions from existing literature, with CDV-A outperforming or matching expert-determined crossover locations.

## How to Use

The repository includes a complete MATLAB implementation of the CDV-A algorithm. The accompanying documentation and examples demonstrate its application to both synthetic and real-world datasets. 

## Citation

If you use the CDV-A algorithm in your work, please cite the corresponding research article:

*Moreno-Pulido, S., de la Torre, J. C., Ruiz, P., & Pavón-Domínguez, P. (2024). Crossover detection based on variances of slope differences for multi-fractal detrended fluctuation analysis (MF-DFA). Nonlinear Dynamics.* DOI: [10.1007/s11071-024-10478-1](https://doi.org/10.1007/s11071-024-10478-1) 

## Contact

For any questions or contributions, please contact the authors at the University of Cádiz, Spain. 

Explore the repository and leverage the CDV-A algorithm for your multi-fractal analysis needs!
