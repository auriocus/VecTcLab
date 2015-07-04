package provide vectcl::plot 0.5
package require snit
package require ukaz

namespace eval vectcl::plot {
	variable instcounter 0
	proc figure {} {
		variable instcounter
		incr instcounter
		set tl .fig$instcounter
		Figure $tl
	}
	
	namespace export figure

	snit::widget Figure {
		hulltype toplevel
		component plot
		delegate option * to plot
		delegate method * to plot except plot
		constructor {args} {
			install plot using ukaz::graph $win.plot
			pack $plot -fill both -expand yes
			$self configurelist $args
		}

		method plot {x y args} {
			# combine x and y into one array
			if {[numarray dimensions $x]!=1 || [numarray dimensions $y]!=1} {
				return -code error "x and y must be vectors of equal length!"
			}
			set coords {}
			foreach xc $x yc $y {
				lappend coords $xc $yc
			}
			$plot plot $coords {*}$args
		}

	}
}

