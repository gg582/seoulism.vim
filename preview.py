import matplotlib.pyplot as plt
import matplotlib.patches as patches

def draw_seoulism_blueprint():
    # 1. Systemic Mapping Data
    mapping = [
        {"id": "c6", "tag": "JADE",   "hex": "#3aa39a", "element": "WOOD",    "logic": "Birth / Formatter, Function"},
        {"id": "c1", "tag": "RED",    "hex": "#e05a55", "element": "FIRE",    "logic": "Dread / Alert / Syntax"},
        {"id": "c3", "tag": "GOLD",   "hex": "#e5c15a", "element": "EARTH",   "logic": "Origin / Literal"},
        {"id": "c4", "tag": "BLUE",   "hex": "#3f6bd9", "element": "WOOD(LINK)",    "logic": "Reference / Navigation"},
        {"id": "m1", "tag": "WHITE",  "hex": "#efeeea", "element": "METAL",   "logic": "Structure / Type"},
        {"id": "fg", "tag": "BASE",   "hex": "#b6b5a8", "element": "CORE",    "logic": "Content / Neutral"},
        {"id": "c0", "tag": "SHADOW", "hex": "#5f6770", "element": "VOID",    "logic": "Shadow / Meta"},
    ]

    # 2. Architectonic Layout
    bg_main = '#111116'
    bg_base = '#07070a'

    fig, ax = plt.subplots(figsize=(12, 9), facecolor=bg_base)
    ax.set_facecolor(bg_main)
    ax.set_xlim(0, 100)
    ax.set_ylim(0, 100)
    ax.axis('off')

    # Header: Technical Specification
    ax.text(10, 92, "SEOULISM: Systemic Cognitive Mapping",
            color='#b6b5a8', fontsize=20, ha='left', weight='bold')
    ax.text(10, 89, "Functional implementation of Obangsaek logic",
            color='#3aa39a', fontsize=10, ha='left', style='italic')

    # 3. Structural Grid Rendering
    for i, item in enumerate(mapping):
        y = 75 - (i * 10)

        # Color Anchor
        rect = patches.Rectangle((10, y), 4, 6, facecolor=item['hex'], antialiased=True)
        ax.add_patch(rect)

        # Technical Labels
        ax.text(16, y + 3, item['id'].upper(), color='#b6b5a8',
                fontsize=11, va='center', weight='bold', family='monospace')

        ax.text(25, y + 3, item['hex'], color='#7f85ac',
                fontsize=10, va='center', family='monospace')

        # Logic Mapping
        ax.text(40, y + 4.5, f"ELEMENT: {item['element']}",
                color=item['hex'], fontsize=8, va='center', weight='black')
        ax.text(40, y + 1.5, f"LOGIC: {item['logic']}",
                color='#b6b5a8', fontsize=11, va='center', alpha=0.8)

        # Divider line for structural feel
        ax.plot([10, 90], [y - 2, y - 2], color='#2b2e36', linewidth=0.5)

    plt.tight_layout()
    plt.savefig('preview.png', facecolor=bg_base, dpi=300)

if __name__ == "__main__":
    draw_seoulism_blueprint()
