// rest in peace the_very_holy_global_bible_list_amen (??? - 2020)
var/global/list/bible_contents = list()

/obj/item/storage/bible //keyword: ol bib
	name = "ol' bib"
	desc = "A facsimile of a xerox of a copy of a daguerrotype of some historical italian text. Someone seems to have hollowed it out for hiding things in."
	icon_state ="bible"
	inhand_image_icon = 'icons/mob/inhand/hand_books.dmi'
	item_state ="bible"
	throw_speed = 1
	throw_range = 5
	w_class = W_CLASS_NORMAL
	max_wclass = 2
	flags = FPRINT | TABLEPASS | NOSPLASH
	event_handler_flags = USE_FLUID_ENTER | IS_FARTABLE
	var/mob/affecting = null
	var/heal_amt = 10

	New()
		..()
		START_TRACKING

		BLOCK_SETUP(BLOCK_BOOK)

	disposing()
		..()
		STOP_TRACKING

	proc/bless(mob/M as mob, var/mob/user)
		if (isvampire(M) || iswraith(M) || M.bioHolder.HasEffect("revenant"))
			M.visible_message("<span class='alert'><B>[M] burns!</span>", 1)
			var/zone = "chest"
			if (user.zone_sel)
				zone = user.zone_sel.selecting
			M.TakeDamage(zone, 0, heal_amt)
			JOB_XP(user, "Chaplain", 2)
		else
			var/mob/living/H = M
			if( istype(H) )
				if( prob(25) )
					H.delStatus("bloodcurse")
					//H.cure_disease_by_path(/datum/ailment/disease/cluwneing_around/cluwne) // No Respite for Cluwnes - warc
				//if(prob(25))
					//H.cure_disease_by_path(/datum/ailment/disability/clumsy/cluwne)  // No Respite for Cluwnes - warc
			M.HealDamage("All", heal_amt, heal_amt)
			if(prob(40))
				JOB_XP(user, "Chaplain", 1)

	attackby(var/obj/item/W, var/mob/user, obj/item/storage/T)
		if (istype(W, /obj/item/storage/bible))
			user.show_text("You try to put \the [W] in \the [src]. It doesn't work. You feel dumber.", "red")
		else
			..()

	attack(mob/M as mob, mob/user as mob)
		var/chaplain = 0
		if (user.traitHolder && user.traitHolder.hasTrait("training_chaplain"))
			chaplain = 1
		if (!chaplain)
			boutput(user, "<span class='alert'>The book sizzles in your hands.</span>")
			user.TakeDamage(user.hand == 1 ? "l_arm" : "r_arm", 0, 10)
			return
		if (user.bioHolder && user.bioHolder.HasEffect("clumsy") && prob(50))
			user.visible_message("<span class='alert'><b>[user]</b> fumbles and drops [src] on [his_or_her(user)] foot.</span>")
			random_brute_damage(user, 10)
			user.changeStatus("stunned", 3 SECONDS)
			JOB_XP(user, "Clown", 1)
			return

	//	if(..() == BLOCKED)
	//		return

		if (iswraith(M) || (M.bioHolder && M.bioHolder.HasEffect("revenant")))
			M.visible_message("<span class='alert'><B>[user] smites [M] with the [src]!</B></span>")
			bless(M, user)
			boutput(M, "<span_class='alert'><B>IT BURNS!</B></span>")
			if (narrator_mode)
				playsound(src.loc, 'sound/vox/hit.ogg', 25, 1, -1)
			else
				playsound(src.loc, "punch", 25, 1, -1)
			logTheThing("combat", user, M, "biblically smote [constructTarget(M,"combat")]")

		else if (!isdead(M))
			var/mob/H = M
			// ******* Check
			if ((ishuman(H) && prob(60) && !(M.traitHolder?.hasTrait("atheist"))))
				bless(M, user)
				M.visible_message("<span class='alert'><B>[user] heals [M] with the power of [src]!</B></span>")
				boutput(M, "<span class='alert'>May the power of [src] compel you to be healed!</span>")
				if (narrator_mode)
					playsound(src.loc, 'sound/vox/hit.ogg', 25, 1, -1)
				else
					playsound(src.loc, "punch", 25, 1, -1)
				logTheThing("combat", user, M, "ol'biblically healed [constructTarget(M,"combat")]")
			else
				if (ishuman(M) && !istype(M:head, /obj/item/clothing/head/helmet))
					if (M.traitHolder?.hasTrait("atheist"))
						M.take_brain_damage(5)
					else
						M.take_brain_damage(10)
					boutput(M, "<span class='alert'>You feel dazed from the blow to the head.</span>")
				logTheThing("combat", user, M, "ol'biblically injured [constructTarget(M,"combat")]")
				M.visible_message("<span class='alert'><B>[user] beats [M] over the head with [src]!</B></span>")
				if (narrator_mode)
					playsound(src.loc, 'sound/vox/hit.ogg', 25, 1, -1)
				else
					playsound(src.loc, "punch", 25, 1, -1)
		else if (isdead(M))
			M.visible_message("<span class='alert'><B>[user] smacks [M]'s lifeless corpse with [src].</B></span>")
			if (narrator_mode)
				playsound(src.loc, 'sound/vox/hit.ogg', 25, 1, -1)
			else
				playsound(src.loc, "punch", 25, 1, -1)
		return

	attack_hand(var/mob/user as mob)
		if (isvampire(user) || user.bioHolder.HasEffect("revenant"))
			user.visible_message("<span class='alert'><B>[user] tries to take the [src], but their hand bursts into flames!</B></span>", "<span class='alert'><b>Your hand bursts into flames as you try to take the [src]! It burns!</b></span>")
			user.TakeDamage(user.hand == 1 ? "l_arm" : "r_arm", 0, 25)
			user.changeStatus("stunned", 15 SECONDS)
			user.changeStatus("weakened", 15 SECONDS)
			return
		return ..()

	get_contents()
		return bible_contents

	get_all_contents()
		var/list/L = list()
		L += bible_contents
		for (var/obj/item/storage/S in bible_contents)
			L += S.get_all_contents()
		return L

	contains(var/atom/A)
		if(!A)
			return 0
		return (A in bible_contents)

	add_contents(obj/item/I)
		bible_contents += I
		I.set_loc(null)
		for_by_tcl(bible, /obj/item/storage/bible)
			bible.hud.update() // fuck bibles

	custom_suicide = 1
	suicide_distance = 0
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		if (!farting_allowed)
			return 0

		user.u_equip(src)
		src.layer = initial(src.layer)
		src.set_loc(user.loc)
		return farty_heresy(user)

	proc/farty_heresy(mob/user)
		if(!user || user.loc != src.loc)
			return 0

		if (farty_party)
			user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>The book seems to approve.</b></span>")
			return 0

		if (user.traitHolder?.hasTrait("atheist"))
			user.visible_message("<span class='alert'>[user] farts on ol' bib with particular vindication.<br><b> Weirdo.</b></span>")
			return 0
		else
			user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>[user] decides to dissociate a little!</b></span>")
			logTheThing("combat", user, null, "farted on [src] at [log_loc(src)] last touched by <b>[src.fingerprintslast ? src.fingerprintslast : "unknown"]</b>.")
			user.gib()
			return 0

/obj/item/storage/bible/evil
	name = "frayed bible"
	event_handler_flags = USE_HASENTERED | USE_FLUID_ENTER | IS_FARTABLE

	HasEntered(atom/movable/AM as mob)
		..()
		if(ishuman(AM))
			var/mob/living/carbon/human/H = AM
			H.emote("fart")

/obj/item/storage/bible/mini
	//Grif
	name = "Ol' Piccola Bib"
	desc = "For when you don't want the good book to take up too much space in your life."
	icon_state = "minibible"
	item_state = null
	w_class = W_CLASS_SMALL

	farty_heresy(mob/user) //fuk u always die
		if(!user || user.loc != src.loc)
			return 0
		user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>[user] just kind of goes away!</b></span>")
		logTheThing("combat", user, null, "farted on [src] at [log_loc(src)] last touched by <b>[src.fingerprintslast ? src.fingerprintslast : "unknown"]</b>.")
		user.gib()
		return 0

/obj/item/storage/bible/hungry
	name = "hungry bible"
	desc = "Huh."

	custom_suicide = 1
	suicide_distance = 0
	suicide(var/mob/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		if (!farting_allowed)
			return 0
		if (farty_party)
			user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>The book seems to approve.</b></span>")
			return 0
		user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>Stuff happens! Vore stuff!</b></span>")
		user.u_equip(src)
		src.layer = initial(src.layer)
		src.set_loc(user.loc)
		var/list/gibz = user.gib(0, 1)
		SPAWN_DBG(3 SECONDS)//this code is awful lol.
			for( var/i = 1, i <= 500, i++ )
				for( var/obj/gib in gibz )
					if(!gib.loc) continue
					step_to( gib, src )
					if( get_dist( gib, src ) == 0 )
						animate( src, pixel_x = rand(-3,3), pixel_y = rand(-3,3), time = 3 )
						qdel( gib )
						if(prob( 50 )) playsound( get_turf( src ), 'sound/voice/burp.ogg', 10, 1 )
				sleep(0.3 SECONDS)
		return 1
	farty_heresy(var/mob/user)
		if (farty_party)
			user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>The book seems to approve.</b></span>")
			return 0
		user.visible_message("<span class='alert'>[user] farts on ol' bib.<br><b>The Ol' Book has its day.</b></span>")
		user.u_equip(src)
		src.layer = initial(src.layer)
		src.set_loc(user.loc)
		var/list/gibz = user.gib(0, 1)
		SPAWN_DBG(3 SECONDS)//this code is awful lol.
			for( var/i = 1, i <= 50, i++ )
				for( var/obj/gib in gibz )
					step_to( gib, src )
					if( get_dist( gib, src ) == 0 )
						animate( src, pixel_x = rand(-3,3), pixel_y = rand(-3,3), time = 3 )
						qdel( gib )
						if(prob( 50 )) playsound( get_turf( src ), 'sound/voice/burp.ogg', 10, 1 )
				sleep(0.3 SECONDS)
		return 1
