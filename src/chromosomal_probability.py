import random
import math

def simulate_chromosomal_distribution(total_sperm_count_millions=250.0, target_y_ratio=0.50):
    """
    Simulates the statistical distribution of X and Y chromosome sperm counts
    within a standard ejaculate volume using a binomial-to-normal distribution mapping.
    """
    print(f"[*] Initializing Gamete Distribution Simulation...")
    print(f"    - Total Input Population: {total_sperm_count_millions:.1f} Million Spermatozoa")
    print(f"    - Theoretical Split Target: {target_y_ratio*100:.1f}% Y-Sperm / {(1-target_y_ratio)*100:.1f}% X-Sperm")
    
    # Scale simulation parameters (converting millions to granular tracking units)
    # Using normal approximation to the binomial distribution: mean = n*p, std = sqrt(n*p*(1-p))
    n = total_sperm_count_millions * 1_000_000
    p = target_y_ratio
    
    mean_y = n * p
    std_dev_y = math.sqrt(n * p * (1 - p))
    
    # Generate a stochastic runtime sample point using a random Gaussian distribution
    simulated_y_count = random.gauss(mean_y, std_dev_y)
    simulated_x_count = n - simulated_y_count
    
    # Calculate real-world fractional percentages
    final_y_percent = (simulated_y_count / n) * 100
    final_x_percent = (simulated_x_count / n) * 100
    
    print(f"[+] Stochastic Fluid Sort Matrix Compiled Successfully:")
    print(f"    - Simulated X-Sperm (Female Outcome): {simulated_x_count / 1_000_000:.4f} Million ({final_x_percent:.4f}%)")
    print(f"    - Simulated Y-Sperm (Male Outcome)  : {simulated_y_count / 1_000_000:.4f} Million ({final_y_percent:.4f}%)")
    
    # Calculate localized sample variance deflection
    deviation_from_mean = abs(simulated_y_count - mean_y) / std_dev_y
    print(f"    - Statistical Variance Profile      : {deviation_from_mean:.2f} Standard Deviations from Mean\n")
    
    return {
        "x_count_millions": simulated_x_count / 1_000_000,
        "y_count_millions": simulated_y_count / 1_000_000,
        "y_ratio_percent": final_y_percent
    }

if __name__ == "__main__":
    # Test a standard baseline clinical sample count
    simulate_chromosomal_distribution(total_sperm_count_millions=300.0)
    # Test a lower threshold clinical sample count
    simulate_chromosomal_distribution(total_sperm_count_millions=80.0)
