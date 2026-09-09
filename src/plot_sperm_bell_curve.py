import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats

def plot_chromosomal_pdf(total_sperm_count_millions=250.0, target_y_ratio=0.50):
    """
    Computes and plots the normal approximation PDF curve for the 
    Y-chromosome distribution inside a given total sample size.
    """
    print("[*] Generating Analytical Graph Window...")
    
    # Mathematical parameters mapping the sample size down to millions for readability
    n = total_sperm_count_millions  # Total population baseline axis
    p = target_y_ratio
    
    mean = n * p
    std_dev = np.sqrt(n * p * (1 - p))
    
    # Generate X-axis values spanning 4 standard deviations out from the mean
    x_axis = np.linspace(mean - 4*std_dev, mean + 4*std_dev, 500)
    pdf_curve = stats.norm.pdf(x_axis, mean, std_dev)
    
    # Initialize Visual Canvas
    plt.figure(figsize=(10, 5.5))
    plt.plot(x_axis, pdf_curve, label='Y-Chromosomal Probability Density', color='darkblue', linewidth=2.5)
    plt.fill_between(x_axis, pdf_curve, color='royalblue', alpha=0.3)
    
    # Annotate Key Points of Interest
    plt.axvline(x=mean, color='crimson', linestyle='--', linewidth=1.5, label=f'Expected Mean ({mean:.1f}M)')
    
    plt.title('Statistical Probability Density Function (PDF) of Chromosomal Sorting', fontsize=12, pad=15)
    plt.xlabel('Simulated Y-Chromosome Count in Ejaculate (Millions)', fontsize=10)
    plt.ylabel('Probability Density Score', fontsize=10)
    
    plt.grid(True, which='both', linestyle=':', alpha=0.6)
    plt.legend(loc='upper right', frameon=True)
    
    output_filename = "hardware/chromosomal_pdf_curve.png"
    plt.savefig(output_filename, bbox_inches='tight', dpi=150)
    plt.close()
    print(f"[+] High-resolution analysis plot saved successfully to: {output_filename}")

if __name__ == "__main__":
    plot_chromosomal_pdf(total_sperm_count_millions=250.0, target_y_ratio=0.50)
