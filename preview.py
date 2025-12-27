import matplotlib.pyplot as plt
import matplotlib.patches as patches

def draw_seoulism_blueprint():
    # 1. Systemic Mapping Data
    mapping = [
        {"id": "c6", "tag": "JADE",   "hex": "#2AA394", "element": "WOOD",    "logic": "Birth / Formatter"},
        {"id": "c1", "tag": "RED",    "hex": "#EA3C36", "element": "FIRE",    "logic": "Dread / Alert"},
        {"id": "c3", "tag": "GOLD",   "hex": "#F6C940", "element": "EARTH",   "logic": "Origin / Literal"},
        {"id": "c4", "tag": "BLUE",   "hex": "#2C5AE0", "element": "LINK",    "logic": "Reference / Navigation"},
        {"id": "c5", "tag": "PURPLE", "hex": "#9C5FE8", "element": "POLARIS", "logic": "Wisdom / Syntax"},
        {"id": "m1", "tag": "WHITE",  "hex": "#ECECE9", "element": "METAL",   "logic": "Structure / Type"},
        {"id": "fg", "tag": "BASE",   "hex": "#ECECE9", "element": "CORE",    "logic": "Content / Neutral"},
        {"id": "c0", "tag": "SHADOW", "hex": "#80858C", "element": "VOID",    "logic": "Shadow / Meta"},
    ]

    # 2. Architectonic Layout
    bg_main = '#101114'
    bg_base = '#070709'

    fig, ax = plt.subplots(figsize=(12, 9), facecolor=bg_base)
    ax.set_facecolor(bg_main)
    ax.set_xlim(0, 100)
    ax.set_ylim(0, 100)
    ax.axis('off')

    # Header: Technical Specification
    ax.text(10, 92, "SEOULISM: Systemic Cognitive Mapping",
            color='#ECECE9', fontsize=20, ha='left', weight='bold')
    ax.text(10, 89, "Functional implementation of Obangsaek logic",
            color='#2AA394', fontsize=10, ha='left', style='italic')

    # 3. Structural Grid Rendering
    for i, item in enumerate(mapping):
        y = 75 - (i * 10)

        # Color Anchor
        rect = patches.Rectangle((10, y), 4, 6, facecolor=item['hex'], antialiased=True)
        ax.add_patch(rect)

        # Technical Labels
        ax.text(16, y + 3, item['id'].upper(), color='#ECECE9',
                fontsize=11, va='center', weight='bold', family='monospace')

        ax.text(25, y + 3, item['hex'], color='#80858c',
                fontsize=10, va='center', family='monospace')

        # Logic Mapping
        ax.text(40, y + 4.5, f"ELEMENT: {item['element']}",
                color=item['hex'], fontsize=8, va='center', weight='black')
        ax.text(40, y + 1.5, f"LOGIC: {item['logic']}",
                color='#ECECE9', fontsize=11, va='center', alpha=0.8)

        # Divider line for structural feel
        ax.plot([10, 90], [y - 2, y - 2], color='#242630', linewidth=0.5)

    plt.tight_layout()
    plt.savefig('preview.png', facecolor=bg_base, dpi=300)
    plt.show()

if __name__ == "__main__":
    draw_seoulism_blueprint()

