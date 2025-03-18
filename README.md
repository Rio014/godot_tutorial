# Note to myself

- We created player scene, mob scene separately, then use it in the main game scene by instantiate it.

- The reason we instantiate player scene this way (as opposed to do the same way as mob) is because there is only one player in this game.

nice design 
- Have HUD emits signal to main so that we know when to start game. In this tutorial, they use clicking start button as a signal.
- If we want an action to applies to all entity (same kind) then we can group them under one name and then apply the action.