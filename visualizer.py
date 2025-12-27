import matplotlib.pyplot as plt
import networkx as nx

def draw_seoulism_chain():
    """
    Visualizes the systemic cognitive chain of the Seoulism palette.
    It maps traditional 'Obangsaek' logic to modern functional programming roles.
    """
    
    # 1. Data Schema: (Direction, Element, Traditional Color, Trad Hex, Seoulism Token, Seoulism Hex, Cognitive Role)
    # This maps the ancestral systemic logic to the actual Vim palette provided.
    chains = [
        ("Birth", "Wood", "Blue/Jade", "#0000FF", "Jade (c6)", "#2aa394", "Format / Function"),
        ("Dread", "Fire", "Red", "#FF0000", "Red (c1)", "#ea3c36", "Alert / Error"),
        ("Origin", "Earth", "Yellow", "#FFFF00", "Gold (c3)", "#f6c940", "Literal / Data"),
        ("Structure", "Metal", "White", "#FFFFFF", "Foreground", "#ecece9", "Base / Structure"),
        ("Void", "Water", "Black", "#000000", "Background", "#101114", "Space / Void"),
        # Intermediary color representing the systemic framework
        ("Wisdom", "Polaris", "Purple", "#800080", "Purple (c5)", "#8749ad", "Keyword / Syntax")
    ]

    G = nx.DiGraph()
    pos = {}
    node_colors = []
    labels = {}

    # 2. Node Generation and Layout Mapping
    for i, (dir_name, elem, trad_name, trad_hex, pal_name, pal_hex, cogn_func) in enumerate(chains):
        # Defining the hierarchy of the chain
        steps = [dir_name, elem, trad_name, pal_name, cogn_func]
        
        for j, step_label in enumerate(steps):
            node_id = f"{i}_{j}"
            G.add_node(node_id)
            # Layout: X-axis represents the cognitive stage, Y-axis represents the color axis
            pos[node_id] = (j * 2.2, -i * 1.5) 
            labels[node_id] = step_label
            
            # Assigning colors based on the stage of the chain
            if j == 2: # Traditional anchor stage
                node_colors.append(trad_hex)
            elif j == 3: # Seoulism implementation stage
                node_colors.append(pal_hex)
            else: # Neutral tones for conceptual labels
                node_colors.append("#464e56") # Using c0 from your palette

            # Creating the sequential links (The Chain)
            if j > 0:
                G.add_edge(f"{i}_{j-1}", node_id)

    # 3. Visualization Configuration using Seoulism palette colors
    plt.figure(figsize=(16, 9), facecolor='#070709') # BackgroundFaint
    ax = plt.gca()
    ax.set_facecolor('#070709')

    # Drawing the "Chains" (Edges)
    nx.draw_networkx_edges(G, pos, edge_color='#242630', arrowsize=20, width=1.2) # BackgroundIntense

    # Drawing the Nodes
    nx.draw_networkx_nodes(G, pos, node_color=node_colors, node_size=3200, 
                           edgecolors='#bebeba', linewidths=0.5) # ForegroundFaint

    # Label Rendering with contrast-aware coloring
    for node, (x, y) in pos.items():
        node_idx = list(G.nodes()).index(node)
        hex_color = node_colors[node_idx]
        
        # Determining text contrast
        # For the Seoulism/Traditional stages, we use dark text on light nodes
        stage_idx = int(node.split('_')[1])
        if stage_idx in [2, 3]:
            # Simple brightness check: Dark text for light colors (Yellow/White/Jade)
            text_color = '#101114' if any(c in hex_color.lower() for c in ['f', 'e', 'd']) else '#ecece9'
        else:
            text_color = '#bebeba'
        
        plt.text(x, y, labels[node], fontsize=8, ha='center', va='center', 
                 fontweight='bold', color=text_color, wrap=True)

    # Header Labels for the Cognitive Stages
    headers = ["Direction", "Element", "Trad. Anchor", "Seoulism Token", "Cognitive Role"]
    for i, header in enumerate(headers):
        plt.text(i * 2.2, 0.8, header, fontsize=11, color='#f6c940', # Gold c3
                 ha='center', fontweight='extra bold')

    plt.title("Systemic Cognitive Mapping: From Elemental Logic to Seoulism", 
              color='#ecece9', fontsize=15, pad=40, fontweight='bold')
    
    plt.axis('off')
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    draw_seoulism_chain()
