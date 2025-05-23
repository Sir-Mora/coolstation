proc/BeginSpacePush(var/atom/movable/A)
	if (!(A.temp_flags & SPACE_PUSHING))
		spacePushList += A
		A.temp_flags |= SPACE_PUSHING

proc/EndSpacePush(var/atom/movable/A)
	if(ismob(A))
		var/mob/M = A
		M.inertia_dir = 0
	spacePushList -= A
	A.temp_flags &= ~SPACE_PUSHING

/// Controls forced movements
/datum/controller/process/fMove
	var/list/debugPushList = null //Remove this on release.

	setup()
		name = "Forced movement"
		schedule_interval = 0.5 SECONDS

	doWork()
		//space first :)
		for (var/atom/movable/M as anything in spacePushList)
			if(!M)
				continue

			var/turf/T = M.loc
			if (!istype(T) || (!(T.turf_flags & CAN_BE_SPACE_SAMPLE || T.throw_unlimited) || T != M.loc) && !M.no_gravity)
				EndSpacePush(M)
				continue

			if (ismob(M))
				var/mob/tmob = M
				if(tmob.client && tmob.client.flying)
					EndSpacePush(M)
					continue

				if (T && T.turf_flags & CAN_BE_SPACE_SAMPLE || M.no_gravity)
					var/prob_slip = 5

					if (tmob.hasStatus("handcuffed"))
						prob_slip = 100

					if (!tmob.canmove)
						prob_slip = 100

					for (var/atom/AA in oview(1,tmob))
						if (AA.stops_space_move && (!M.no_gravity || !isfloor(AA)))
							if (!( tmob.l_hand ))
								prob_slip -= 3
							else if (tmob.l_hand.w_class <= W_CLASS_SMALL)
								prob_slip -= 1

							if (!( tmob.r_hand ))
								prob_slip -= 2
							else if (tmob.r_hand.w_class <= W_CLASS_SMALL)
								prob_slip -= 1

							break

					prob_slip = floor(prob_slip)
					if (prob_slip < 5) //next to something, but they might slip off
						if (prob(prob_slip) )
							tmob.lastgasp()
							boutput(tmob, "<span class='notice'><B>You slipped!</B></span>")
							tmob.inertia_dir = tmob.last_move
							step(tmob, tmob.inertia_dir)
							continue
						else
							EndSpacePush(M)
							continue

				else
					var/end = 0
					for (var/atom/AA in oview(1,tmob))
						if (AA.stops_space_move && (!M.no_gravity || !isfloor(AA)))
							end = 1
							break
					if (end)
						EndSpacePush(M)
						continue


				if (M && !( M.anchored ) && !(M.flags & NODRIFT))
					if (! (TIME > (tmob.l_move_time + schedule_interval)) ) //we need to stand still for 5 realtime ticks before space starts pushing us!
						continue

					var/pre_inertia_loc = M.loc

					var/glide = (32 / schedule_interval) * world.tick_lag
					tmob.glide_size = glide
					tmob.animate_movement = SLIDE_STEPS

					if(tmob.inertia_dir) //they keep moving the same direction
						var/original_dir = tmob.dir
						step(tmob, tmob.inertia_dir)
						tmob.set_dir(original_dir)
					else
						tmob.inertia_dir = tmob.last_move
						step(tmob, tmob.inertia_dir)

					tmob.glide_size = glide

					if(tmob.loc == pre_inertia_loc) //something stopped them from moving so cancel their inertia
						tmob.inertia_dir = 0
				else
					EndSpacePush(M)
					continue

			else if (isobj(M))
				var/glide = (32 / schedule_interval) * world.tick_lag
				M.glide_size = glide
				M.animate_movement = SLIDE_STEPS

				step(M, M.last_move)

				M.glide_size = glide
			else
				EndSpacePush(M)
				continue

			if(M.loc == T) // we didn't move, probably hit something
				EndSpacePush(M)
				continue
		return

	tickDetail()
		boutput(usr, "<b>ForcedMovement:</b> Managing [spacePushList.len] spacepush objects")
