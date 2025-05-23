//FLAGS BITMASK

/// atom that forms part of the game's guts outside of the kayfabe, and should generally be excluded from being directly affected by game systems
#define TECHNICAL_ATOM					 (1<<0)
/// can pass by a table or rack
#define TABLEPASS						 (1<<1)
/// thing doesn't drift in space
#define NODRIFT							 (1<<2)
/// put this on either a thing you don't want to be hit rapidly, or a thing you don't want people to hit other stuff rapidly with
#define USEDELAY						 (1<<3)
/// 1 second extra delay on use
#define EXTRADELAY					 (1<<4)
/// weapon not affected by shield. MBC also put this flag on cloak/shield device to minimize istype checking, so consider this more SHIELD_ACT (rename? idk)
#define NOSHIELD						 (1<<5)
/// conducts electricity (metal etc.)
#define CONDUCT							 (1<<6)
/// can be put in belt slot
#define ONBELT							 (1<<7)
/// takes a fingerprint
#define FPRINT							 (1<<8)
/// item has priority to check when entering or leaving
#define ON_BORDER						 (1<<9)
/// can pass through a closed door
#define DOORPASS						 (1<<10)
/// can be put in back slot
#define ONBACK							 (1<<11) //fuck you you don't get to be first anymore
/// is an open container for chemistry purposes
#define OPENCONTAINER				 (1<<12)
/// No beaker etc. splashing. For Chem machines etc.
#define NOSPLASH 						 (1<<13)
/// No attack when hitting stuff with this item.
#define SUPPRESSATTACK 			 (1<<14)
/// gets an overlay when submerged in fluid
#define FLUID_SUBMERGE 			 (1<<15)
/// gets a perspective overlay from adjacent fluids
#define IS_PERSPECTIVE_FLUID (1<<16)
/// specifically note this object as solid
#define ALWAYS_SOLID_FLUID	 (1<<17)
///FREE
//#define (1<<18)
/// Has the possibility for a TGUI interface
#define TGUI_INTERACTIVE		 (1<<19)
///FREE
//#define (1<<20)
/// Is currently scaled by bubsium
#define IS_BUBSIUM_SCALED		 (1<<21)
/// Does not get nuked by the mineral magnet area clear (does not block activating the magnet), not needed for things with TECHNICAL_ATOM
#define MINERAL_MAGNET_SAFE (1<<22)
/// Is currently scaled by siladenafil
#define IS_BONER_SCALED		 (1<<23)
//WE CAN'T HAVE MORE THAN 24 FLAGS


//Item function flags (item_function_flags)

/// apply to an item's flags to use the item's intent_switch_trigger() proc. This will be called when intent is switched while this item is in hand.
#define USE_INTENT_SWITCH_TRIGGER (1<<0)
/// allows special attacks to be performed on help and grab intent with this item
#define USE_SPECIALS_ON_ALL_INTENTS (1<<1)
/// prevents items from creating smoke while burning
#define SMOKELESS 				(1<<2)
/// makes items immune to acid
#define IMMUNE_TO_ACID 			(1<<3)
/// prevents items from heating anything up while burning
#define COLD_BURN (1<<4)
/// automagically talk into this object when a human is holding it (Phone handset!)
#define TALK_INTO_HAND 			 (1<<5)
/// Calls equipment_click from hand_range_attack on items worn with this flag set.
#define HAS_EQUIP_CLICK			 (1<<6)
/// Has a click delay for attack_self()
#define ATTACK_SELF_DELAY		 (1<<7)

//tool flags
#define TOOL_CLAMPING (1<<0)
#define TOOL_CUTTING (1<<1)
#define TOOL_PRYING (1<<2)
#define TOOL_PULSING (1<<3)
#define TOOL_SAWING (1<<4)
#define TOOL_SCREWING (1<<5)
#define TOOL_SNIPPING (1<<6)
#define TOOL_SPOONING (1<<7)
#define TOOL_WELDING (1<<8)
#define TOOL_WRENCHING (1<<9)
#define TOOL_CHOPPING (1<<10) // for fireaxes, does additional damage to doors.
#define TOOL_HAMMERING (1<<11) //the ethical option
#define TOOL_OPENFLAME (1<<12)

//tooltip flags for rebuilding

/// rebuild tooltip every single time without exception
#define REBUILD_ALWAYS				1
/// force rebuild if dist does not match cache
#define REBUILD_DIST				2
/// force rebuild if viewer has changed at all
#define REBUILD_USER				4
/// force rebuild if spectrospec status of viewer has changed
#define REBUILD_SPECTRO				8

// blood system and item damage things
#define DAMAGE_BLUNT 1
#define DAMAGE_CUT 2
#define DAMAGE_STAB 4
#define DAMAGE_BURN 8
/// crushing damage is technically blunt damage, but it causes bleeding
#define DAMAGE_CRUSH 16
#define DEFAULT_BLOOD_COLOR "#990000"	// speak for yourself, as a shapeshifting illuminati lizard, my blood is somewhere between lime and leaf green
#define DEFAULT_MUD_COLOR "#964B00"
#define DAMAGE_TYPE_TO_STRING(x) (x == DAMAGE_BLUNT ? "blunt" : x == DAMAGE_CUT ? "cut" : x == DAMAGE_STAB ? "stab" : x == DAMAGE_BURN ? "burn" : x == DAMAGE_CRUSH ? "crush" : "")

//item rarity stuff
#define ITEM_RARITY_POOR 1
#define ITEM_RARITY_COMMON 2
#define ITEM_RARITY_UNCOMMON 3
#define ITEM_RARITY_RARE 4
#define ITEM_RARITY_EPIC 5
#define ITEM_RARITY_LEGENDARY 6
#define ITEM_RARITY_MYTHIC 7

// item comp defs
#define FORCE_EDIBILITY 1
//item attack bitflags
/// The pre-attack signal doesnt want the attack to continue, so don't
#define ATTACK_PRE_DONT_ATTACK 1

// Limb Kind Bitflags, to avoid the funky typecheck spam limbs usually need
/// Limb typically belongs to one of the normal-ass mutantraces
#define LIMB_MUTANT   (1<<0)
/// Limb is robotic in nature
#define LIMB_ROBOT    (1<<1)
/// Limb lighter than the average limb
#define LIMB_LIGHT    (1<<2)
/// Limb heavier than the average limb
#define LIMB_HEAVY    (1<<3)
/// Limb is really heavy
#define LIMB_HEAVIER  (1<<4)
/// Limb is actually tank treads
#define LIMB_TREADS   (1<<5)
/// Limb typically belongs to a shambling abomination
#define LIMB_ABOM     (1<<6)
/// Limb is made of plants
#define LIMB_PLANT    (1<<7)
/// Limb is whatever the heck a hot limb is
#define LIMB_HOT      (1<<8)
/// Limb typically belongs to the restless undead
#define LIMB_ZOMBIE   (1<<9)
/// Limb typically belongs to hunters
#define LIMB_HUNTER   (1<<10)
/// Limb is actually an item stuck to a stump
#define LIMB_ITEM     (1<<11)
/// Limb is made of stone
#define LIMB_STONE    (1<<12)
/// Limb typically belongs to a vicious bear
#define LIMB_BEAR     (1<<13)
/// Limb typically belongs to a brüllbär
#define LIMB_BRULLBAR  (1<<14)
/// Limb typically belongs to a large angry dog
#define LIMB_WOLF     (1<<15)
/// Limb is kinda boney
#define LIMB_SKELLY   (1<<16)

// islimb macros
#define ismutantlimb(x)   HAS_FLAG(x:kind_of_limb, LIMB_MUTANT)
#define isrobotlimb(x)    HAS_FLAG(x:kind_of_limb, LIMB_ROBOT)
#define islightlimb(x)    HAS_FLAG(x:kind_of_limb, LIMB_LIGHT)
#define isheavyrlimb(x)   HAS_FLAG(x:kind_of_limb, LIMB_HEAVY)
#define isheavierlimb(x)  HAS_FLAG(x:kind_of_limb, LIMB_HEAVIER)
#define istread(x)        HAS_FLAG(x:kind_of_limb, LIMB_TREADS)
#define isabomlimb(x)     HAS_FLAG(x:kind_of_limb, LIMB_ABOM)
#define isplantlimb(x)    HAS_FLAG(x:kind_of_limb, LIMB_PLANT)
#define ishotlimb(x)      HAS_FLAG(x:kind_of_limb, LIMB_HOT)
#define iszombielimb(x)   HAS_FLAG(x:kind_of_limb, LIMB_ZOMBIE)
#define ishunterlimb(x)   HAS_FLAG(x:kind_of_limb, LIMB_HUNTER)
#define isitemlimb(x)     HAS_FLAG(x:kind_of_limb, LIMB_ITEM)
#define isstonelimb(x)    HAS_FLAG(x:kind_of_limb, LIMB_STONE)
#define isbearlimb(x)     HAS_FLAG(x:kind_of_limb, LIMB_BEAR)
#define isbrullbarlimb(x)  HAS_FLAG(x:kind_of_limb, LIMB_BRULLBAR)
#define iswolflimb(x)     HAS_FLAG(x:kind_of_limb, LIMB_WOLF)
#define isskeletonlimb(x) HAS_FLAG(x:kind_of_limb, LIMB_SKELLY)
#define ismonsterlimb(x) (HAS_FLAG(x:kind_of_limb, LIMB_ZOMBIE) |\
                          HAS_FLAG(x:kind_of_limb, LIMB_HUNTER) |\
                          HAS_FLAG(x:kind_of_limb, LIMB_BEAR) |\
                          HAS_FLAG(x:kind_of_limb, LIMB_BRULLBAR) |\
                          HAS_FLAG(x:kind_of_limb, LIMB_ABOM) |\
                          HAS_FLAG(x:kind_of_limb, LIMB_WOLF))
#define isrobolimb(x) (HAS_FLAG(x:kind_of_limb, LIMB_ROBOT) |\
                       HAS_FLAG(x:kind_of_limb, LIMB_LIGHT) |\
                       HAS_FLAG(x:kind_of_limb, LIMB_HEAVY) |\
                       HAS_FLAG(x:kind_of_limb, LIMB_HEAVIER) |\
                       HAS_FLAG(x:kind_of_limb, LIMB_TREADS))

#define W_CLASS_TINY 1
#define W_CLASS_SMALL 2
#define W_CLASS_NORMAL 3
#define W_CLASS_BULKY 4
#define W_CLASS_HUGE 5
#define W_CLASS_GIGANTIC 6
#define W_CLASS_BUBSIAN 10

///Anything above this prevents you from swimming
#define SWIMMING_UPPER_W_CLASS_BOUND W_CLASS_SMALL
