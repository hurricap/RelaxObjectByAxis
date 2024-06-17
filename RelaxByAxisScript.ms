fn relaxAlongAxis obj axis relaxAmount relaxIterations =
(
	local selectedVerts = polyOp.getVertSelection obj

	if selectedVerts.isEmpty then
	(
		format "No vertices selected!\n"
	)
	
    local origVerts = for v = 1 to obj.numverts collect (polyOp.getVert obj v)
    polyOp.setVertSelection obj #{}
    modPanel.addModToSelection (Relax())
    $.modifiers[#Relax].Relax_Value = relaxAmount
    $.modifiers[#Relax].iterations = relaxIterations
	collapseStack obj
    for v = 1 to obj.numverts do
    (
        if not (selectedVerts[v]) do
        (
            local origPos = origVerts[v]
            local relaxedPos = polyOp.getVert obj v
            case axis of
            (
                "x": polyOp.setVert obj v [relaxedPos.x, origPos.y, origPos.z]
                "y": polyOp.setVert obj v [origPos.x, relaxedPos.y, origPos.z]
                "z": polyOp.setVert obj v [origPos.x, origPos.y, relaxedPos.z]
            )
        )
		
		if (selectedVerts[v]) do
        (
			polyOp.setVert obj v origVerts[v]
        )
    )
)

theObj = selection[1]
relaxAlongAxis theObj "z" 0.5 100