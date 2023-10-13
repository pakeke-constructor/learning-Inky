
return Inky.defineElement(function(self)
	self.props.count = 0

	self:onPointer("release", function()
		self.props.count = self.props.count + 1
	end)

	return function(_, x, y, w, h, depth)
        lg.push("all")
        lg.setLineWidth(2)
        lg.setColor(0.1,0.3,0.6)
        lg.rectangle("fill", x,y,w,h)
		lg.rectangle("line", x, y, w, h)
        lg.pop()
	end
end)

