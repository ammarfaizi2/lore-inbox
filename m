Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSKJQiq>; Sun, 10 Nov 2002 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSKJQiq>; Sun, 10 Nov 2002 11:38:46 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:60808 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S264943AbSKJQif>;
	Sun, 10 Nov 2002 11:38:35 -0500
Date: Sun, 10 Nov 2002 10:31:56 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Report Status for 10 Nov
Message-ID: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for not being able to get a report out last week; I'm in the 
middle of a career change (anyone need a system administrator?).  I've 
(mostly) kept up with traffic, but there are a lot of older items I've not 
been able to close out.

The latest version of this list is kept at:
http://members.cox.net/tmolina/kernprobs/status.html

It will remain there until mid-December when I move and lose Cox internet 
access.  I'll be moving to tmolina@copper.net which is a dialup with no 
web page included (They are Linux-friendly though - they don't require 
special software).  I haven't decided yet whether to get a domain and a 
web-hosting service, although there are some out there which don't cost 
much for minimal storage.

I'm hoping most of the older items can be closed out or eliminated.  I'm 
sending a bcc to each with a report on the list.  

                    2.5 Kernel Problem Reports as of 10 Nov
   Status Discussion  Problem Title
   open   24 Oct 2002 AIC7XXX boot failure
   1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356254615324&w=2

------------------------------------------------------------------------
   open   05 Oct 2002 oops in lock_get_status
   2. http://marc.theaimsgroup.com/?l=linux-kernel&m=103244657605155&w=2

------------------------------------------------------------------------
   open   08 Oct 2002 IDE problems on prePCI
   3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2

------------------------------------------------------------------------
   open   09 Oct 2002 USB Mass Storage problems
   4. http://marc.theaimsgroup.com/?l=linux-kernel&m=103404393623200&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 init_irq() function doing unsafe things inside 
                      ide_lock
   5. http://marc.theaimsgroup.com/?l=linux-kernel&m=103316967724891&w=2

------------------------------------------------------------------------
   open   04 Oct 2002 register_console() called in illegal context
   6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2

------------------------------------------------------------------------
   open   09 Oct 2002 eata2x_detect() calls port_detect() under 
                      driver_lock
   7. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281310122580&w=2

------------------------------------------------------------------------
   open   04 Oct 2002 sym_eh_handler does down(&ep->sem) and might sleep
   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103372067026942&w=2

------------------------------------------------------------------------
   open   09 Oct 2002 migration_thread atomicity error
   9. http://marc.theaimsgroup.com/?l=linux-kernel&m=103408159014496&w=2

------------------------------------------------------------------------
   open   08 Oct 2002 snd_via8233 atomicity error
  10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103410375210315&w=2

------------------------------------------------------------------------
   open   31 Oct 2002 atomicity error in sound/pci/via82xx.c
  11. http://marc.theaimsgroup.com/?l=linux-kernel&m=103459664021147&w=2

------------------------------------------------------------------------
   open   11 Oct 2002 scheduling while atomic in autofs4_root_lookup
  12. http://marc.theaimsgroup.com/?l=linux-kernel&m=103426998326969&w=2

------------------------------------------------------------------------
   open   14 Oct 2002 atomicity error in drivers/net/ppp_async.c
  13. http://marc.theaimsgroup.com/?l=linux-kernel&m=103456920802806&w=2

------------------------------------------------------------------------
   open   14 Oct 2002 atomicity error in bond_enslave
  14. http://marc.theaimsgroup.com/?l=linux-kernel&m=103462775624793&w=2

------------------------------------------------------------------------
   open   17 Oct 2002 swsusp atomicity error
  15. http://marc.theaimsgroup.com/?l=linux-kernel&m=103489821623783&w=2

------------------------------------------------------------------------
   open   23 Oct 2002 atomicity error in pcmcia_eject_card
  16. http://marc.theaimsgroup.com/?l=linux-kernel&m=103533605805791&w=2

------------------------------------------------------------------------
   open   03 Oct 2002 ACPI Mutex failure
  17. http://marc.theaimsgroup.com/?l=linux-kernel&m=103369523011536&w=2

------------------------------------------------------------------------
   open   23 Oct 2002 2.5.x and 8250 UART problems
  18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103383019409525&w=2

------------------------------------------------------------------------
   open   19 Oct 2002 mouse/keyboard freeze in X
  19. http://marc.theaimsgroup.com/?l=linux-kernel&m=103441624616220&w=2

------------------------------------------------------------------------
   open   07 Oct 2002 bug related to virtual consoles
  20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403138113853&w=2

------------------------------------------------------------------------
   open   07 Oct 2002 oops in kmem_cache_create
  21. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403423716317&w=2

------------------------------------------------------------------------
   open   07 Oct 2002 USB Hub failure
  22. http://marc.theaimsgroup.com/?l=linux-kernel&m=103402696809279&w=2

------------------------------------------------------------------------
   open   08 Oct 2002 boot problem on 440GX
  23. http://marc.theaimsgroup.com/?l=linux-kernel&m=103399796506960&w=2

------------------------------------------------------------------------
   open   08 Oct 2002 oops while running kjournald
  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103408191314814&w=2

------------------------------------------------------------------------
   open   09 Oct 2002 64GB highmem bug()
  25. http://marc.theaimsgroup.com/?l=linux-kernel&m=103399745406334&w=2

------------------------------------------------------------------------
   open   09 Oct 2002 Attempt to release TCP socket errors
  26. http://marc.theaimsgroup.com/?l=linux-kernel&m=103409524231641&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 raid5 hangs system
  27. http://marc.theaimsgroup.com/?l=linux-kernel&m=103495428502729&w=2

------------------------------------------------------------------------
   open   07 Oct 2002 DRI not working
  28. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403348315804&w=2

------------------------------------------------------------------------
   open   19 Oct 2002 no mouse wheel
  29. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351918416613&w=2

------------------------------------------------------------------------
   open   13 Oct 2002 apm hangs instead of suspending
  30. http://marc.theaimsgroup.com/?l=linux-kernel&m=103454656623320&w=2

------------------------------------------------------------------------
   open   11 Oct 2002 tcp packets lost
  31. http://marc.theaimsgroup.com/?l=linux-kernel&m=103429736523667&w=2

------------------------------------------------------------------------
   open   13 Oct 2002 dual pointing device problem on laptop
  32. http://marc.theaimsgroup.com/?l=linux-kernel&m=103454188820088&w=2

------------------------------------------------------------------------
   open   14 Oct 2002 fbcon oops
  33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103458863514865&w=2

------------------------------------------------------------------------
   open   14 Oct 2002 ACPI/Suspend with an Acer Travelmate 350
  34. http://marc.theaimsgroup.com/?l=linux-kernel&m=103463029127750&w=2

------------------------------------------------------------------------
   open   15 Oct 2002 bug in put_device during rmmod
  35. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470283114965&w=2

------------------------------------------------------------------------
   open   15 Oct 2002 oops stopping serial
  36. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470900729987&w=2

------------------------------------------------------------------------
   open   15 Oct 2002 kernel hangs executing rpcinfo
  37. http://marc.theaimsgroup.com/?l=linux-kernel&m=103462345019675&w=2

------------------------------------------------------------------------
   open   17 Oct 2002 reboot kills Dell Latitude keyboard
  38. http://marc.theaimsgroup.com/?l=linux-kernel&m=103484425027884&w=2

------------------------------------------------------------------------
   open   19 Oct 2002 power down fails after 2.5.41
  39. http://marc.theaimsgroup.com/?l=linux-kernel&m=103479527518536&w=2

------------------------------------------------------------------------
   open   16 Oct 2002 ACPI/Sb16 IRQ conflict
  40. http://marc.theaimsgroup.com/?l=linux-kernel&m=103480163226174&w=2

------------------------------------------------------------------------
   open   17 Oct 2002 oops booting via ide controller
  41. http://marc.theaimsgroup.com/?l=linux-kernel&m=103480082625264&w=2

------------------------------------------------------------------------
   open   22 Oct 2002 IDE not powered down on shutdown
  42. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2

------------------------------------------------------------------------
   open   17 Oct 2002 nfs-related oops
  43. http://marc.theaimsgroup.com/?l=linux-kernel&m=103477312121275&w=2

------------------------------------------------------------------------
   open   17 Oct 2002 neofb oops on shutdown
  44. http://marc.theaimsgroup.com/?l=linux-kernel&m=103485950708944&w=2

------------------------------------------------------------------------
   open   17 Oct 2002 oops inserting xircom_cb network card
  45. http://marc.theaimsgroup.com/?l=linux-kernel&m=103474343128893&w=2

------------------------------------------------------------------------
   open   20 Oct 2002 usb-related boot hang
  46. http://marc.theaimsgroup.com/?l=linux-kernel&m=103463093028435&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 io-apic bug and spinlock deadlock
  47. http://marc.theaimsgroup.com/?l=linux-kernel&m=103482589715521&w=2

------------------------------------------------------------------------
   open   21 Oct 2002 buslogic scsi broke
  48. http://marc.theaimsgroup.com/?l=linux-kernel&m=103496938421117&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 color problem with atyfb
  49. http://marc.theaimsgroup.com/?l=linux-kernel&m=103424151129857&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 ipv4 /proc/net/route bug
  50. http://marc.theaimsgroup.com/?l=linux-kernel&m=103497845730726&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 crash with shared page table
  51. http://marc.theaimsgroup.com/?l=linux-kernel&m=103499186007896&w=2

------------------------------------------------------------------------
   open   18 Oct 2002 qlogic 2x00 driver broke
  52. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470985631070&w=2

------------------------------------------------------------------------
   open   19 Oct 2002 tcq causes filesystem corruption
  53. http://marc.theaimsgroup.com/?l=linux-kernel&m=103498823305987&w=2

------------------------------------------------------------------------
   open   19 Oct 2002 ncr adaptor doesn't see devices
  54. http://marc.theaimsgroup.com/?l=linux-kernel&m=103506893016255&w=2

------------------------------------------------------------------------
   open   21 Oct 2002 unable to eject zip disk
  55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103523397807029&w=2

------------------------------------------------------------------------
   open   21 Oct 2002 isdn badly broken
  56. http://marc.theaimsgroup.com/?l=linux-kernel&m=103513416515540&w=2

------------------------------------------------------------------------
   open   21 Oct 2002 scsi hang on shutdown
  57. http://marc.theaimsgroup.com/?l=linux-kernel&m=103504174230947&w=2

------------------------------------------------------------------------
   open   21 Oct 2002 oops on boot in parport_pc module
  58. http://marc.theaimsgroup.com/?l=linux-kernel&m=103524170815346&w=2

------------------------------------------------------------------------
   open   21 Oct 2002 ZONE_NORMAL exhaustion (dcache slab)
  59. http://marc.theaimsgroup.com/?l=linux-kernel&m=103523368106684&w=2

------------------------------------------------------------------------
   open   23 Oct 2002 2.5.44 fs corruption
  60. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532467828806&w=2

------------------------------------------------------------------------
   open   22 Oct 2002 CS4236B stopping working as of 2.5.44
  61. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532492529636&w=2

------------------------------------------------------------------------
   open   22 Oct 2002 2.5.44-mm1 numa-q panic on boot
  62. http://marc.theaimsgroup.com/?l=linux-kernel&m=103533122402278&w=2

------------------------------------------------------------------------
   open   22 Oct 2002 poisoned oops unmounting ramfs
  63. http://marc.theaimsgroup.com/?l=linux-kernel&m=103530750609277&w=2

------------------------------------------------------------------------
   open   23 Oct 2002 laptop keyboard and mouse not working correctly
  64. http://marc.theaimsgroup.com/?l=linux-kernel&m=103529608426940&w=2

------------------------------------------------------------------------
   open   23 Oct 2002 2.5.44-mm3 oops in hdparm
  65. http://marc.theaimsgroup.com/?l=linux-kernel&m=103536740327325&w=2

------------------------------------------------------------------------
   open   23 Oct 2002 e100 driver fails to initialize
  66. http://marc.theaimsgroup.com/?l=linux-kernel&m=103534286210620&w=2

------------------------------------------------------------------------
   open   24 Oct 2002 serial driver bug with asus motherboard
  67. http://marc.theaimsgroup.com/?l=linux-kernel&m=103548912126308&w=2

------------------------------------------------------------------------
   open   26 Oct 2002 Make xconfig fails
  68. http://marc.theaimsgroup.com/?l=linux-kernel&m=103542716930487&w=2

------------------------------------------------------------------------
   open   24 Oct 2002 oops in n_tty_receive_buf
  69. http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000727447&w=2

------------------------------------------------------------------------
   open   24 Oct 2002 usb mouse insertion problem
  70. http://marc.theaimsgroup.com/?l=linux-kernel&m=103536093721842&w=2

------------------------------------------------------------------------
   open   25 Oct 2002 e100 driver does request_irq and sleeps
  71. http://marc.theaimsgroup.com/?l=linux-kernel&m=103557203302132&w=2

------------------------------------------------------------------------
   open   25 Oct 2002 kvm mouse issues
  72. http://marc.theaimsgroup.com/?l=linux-kernel&m=103559226820595&w=2

------------------------------------------------------------------------
   open   25 Oct 2002 smp boot oops in task_to_steal
  73. http://marc.theaimsgroup.com/?l=linux-kernel&m=103558882018397&w=2

------------------------------------------------------------------------
   open   28 Oct 2002 ohci-hcd Oops on Alpha
  74. http://marc.theaimsgroup.com/?l=linux-kernel&m=103574298430867&w=2

------------------------------------------------------------------------
   open   01 Nov 2002 modular IDE broken
  75. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281667726673&w=2

------------------------------------------------------------------------
   open   01 Nov 2002 atomicity error in hisax_fcpcipnp
  76. http://marc.theaimsgroup.com/?l=linux-kernel&m=103606288004014&w=2

------------------------------------------------------------------------
   open   04 Nov 2002 bug in drivers/block/ll_rw_blk.c
  77. http://marc.theaimsgroup.com/?l=linux-kernel&m=103608787400461&w=2

------------------------------------------------------------------------
   open   01 Nov 2002 Oops on bad floppy for Alpha
  78. http://marc.theaimsgroup.com/?l=linux-kernel&m=103610704123771&w=2

------------------------------------------------------------------------
   open   01 Nov 2002 open file descriptors bug
  79. http://marc.theaimsgroup.com/?l=linux-kernel&m=103610606822889&w=2

------------------------------------------------------------------------
   open   06 Nov 2002 ohci1394 breakage
  80. http://marc.theaimsgroup.com/?l=linux-kernel&m=103659296528243&w=2

------------------------------------------------------------------------
   open   07 Nov 2002 usb problem with io-apic and acpi
  81. http://marc.theaimsgroup.com/?l=linux-kernel&m=103668055114768&w=2

------------------------------------------------------------------------
   open   02 Nov 2002 oops installing usb audio module
  82. http://marc.theaimsgroup.com/?l=linux-kernel&m=103626458107874&w=2

------------------------------------------------------------------------
   open   04 Nov 2002 touchpad no longer works right
  83. http://marc.theaimsgroup.com/?l=linux-kernel&m=103637987303215&w=2

------------------------------------------------------------------------
   open   07 Nov 2002 odd deref in serial_in
  84. http://marc.theaimsgroup.com/?l=linux-kernel&m=103647077515688&w=2

------------------------------------------------------------------------
   open   02 Nov 2002 raid0 initialization failure
  85. http://marc.theaimsgroup.com/?l=linux-kernel&m=103624211526860&w=2

------------------------------------------------------------------------
   open   05 Nov 2002 oops in __wake_up, from pipe_write
  86. http://marc.theaimsgroup.com/?l=linux-kernel&m=103650123803760&w=2

------------------------------------------------------------------------
   open   07 Nov 2002 scsi and/or reiserfs broken
  87. http://marc.theaimsgroup.com/?l=linux-kernel&m=103653771116242&w=2

------------------------------------------------------------------------
   open   07 Nov 2002 timer interrupt related panic
  88. http://marc.theaimsgroup.com/?l=linux-kernel&m=103661036919388&w=2

------------------------------------------------------------------------
   open   07 Nov 2002 packet drop problem
  89. http://marc.theaimsgroup.com/?l=linux-kernel&m=103670963124629&w=2

------------------------------------------------------------------------
   open   05 Nov 2002 bug at fs/block_dev.c
  90. http://marc.theaimsgroup.com/?l=linux-kernel&m=103645405304174&w=2

------------------------------------------------------------------------
   open   05 Nov 2002 oops in snd_timer_free
  91. http://marc.theaimsgroup.com/?l=linux-kernel&m=103651801024013&w=2

------------------------------------------------------------------------
   open   02 Nov 2002 pm doesn't work
  92. http://marc.theaimsgroup.com/?l=linux-kernel&m=103624765529985&w=2

------------------------------------------------------------------------
   open   07 Nov 2002 poweroff after warm reboot problem
  93. http://marc.theaimsgroup.com/?l=linux-kernel&m=103588412714088&w=2

------------------------------------------------------------------------
   open   05 Nov 2002 atomicity error in set_shrinker
  94. http://marc.theaimsgroup.com/?l=linux-kernel&m=103655686631782&w=2

------------------------------------------------------------------------
   open   03 Nov 2002 atomicity error in snd_pcm_oss_write
  95. http://marc.theaimsgroup.com/?l=linux-kernel&m=103630290327713&w=2

------------------------------------------------------------------------
   open   08 Nov 2002 atomicity error in xfs processing
  96. http://marc.theaimsgroup.com/?l=linux-kernel&m=103674989619827&w=2

------------------------------------------------------------------------
   open   08 Nov 2002 scsi panic on reboot
  97. http://marc.theaimsgroup.com/?l=linux-kernel&m=103679752107119&w=2

------------------------------------------------------------------------
   open   08 Nov 2002 irda serial packet drop
  98. http://marc.theaimsgroup.com/?l=linux-kernel&m=103670963124629&w=2

------------------------------------------------------------------------
   open   08 Nov 2002 piix driver oops
  99. http://marc.theaimsgroup.com/?l=linux-kernel&m=103677362411873&w=2

------------------------------------------------------------------------
   open   08 Nov 2002 raid0 bug in submit_bio
 100. http://marc.theaimsgroup.com/?l=linux-kernel&m=103679552704932&w=2

------------------------------------------------------------------------
   open   06 Nov 2002 oops loading eth modules
 101. http://marc.theaimsgroup.com/?l=linux-kernel&m=103660575112739&w=2

------------------------------------------------------------------------
   open   09 Nov 2002 pdc20276 broken on A7V333
 102. http://marc.theaimsgroup.com/?l=linux-kernel&m=103686233309780&w=2

------------------------------------------------------------------------
   open   09 Nov 2002 oops in __wake_up_common
 103. http://marc.theaimsgroup.com/?l=linux-kernel&m=103688304522745&w=2

------------------------------------------------------------------------
   open   10 Nov 2002 spontaneous reboots on A7M266
 104. http://marc.theaimsgroup.com/?l=linux-kernel&m=103693101111270&w=2

------------------------------------------------------------------------


