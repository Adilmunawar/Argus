# Console prototype

`index.html` — a static, clickable prototype of the ZD Cloud Console. Open it in any browser; no build, no server, no data.

It exists to make `docs/10-CONSOLE-DESIGN.md` arguable before anyone writes C#. Six screens are wired: Overview, Applications (Mills), Deployments (with the reconciler plan and blast radius), Compute → sql-01 → **desktop session**, Data, Security → recorded sessions; Identity, Operations and Audit are sketched.

Tokens, type and components come from the Mills dashboard `DESIGN.md` — same `ink`/`muted`/`pine`/`cane`/`brand`/`leaf`/`cream`/`paper`, same Geist + Lora pairing, same 20px card and 12px field radii, same chart palette. The only dark surface in the product is the terminal, as specified.

What to judge it on: is this the screen you would want at 9 a.m., and is the Connect flow one you would trust for `sql-01`? Mark it up and the design document changes before the build starts.
