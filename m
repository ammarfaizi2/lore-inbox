Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSJWCBy>; Tue, 22 Oct 2002 22:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSJWCBy>; Tue, 22 Oct 2002 22:01:54 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:55943 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262664AbSJWCBl>;
	Tue, 22 Oct 2002 22:01:41 -0400
Date: Tue, 22 Oct 2002 21:07:13 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
cc: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: 2.5 Problem Report Status
Message-ID: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is the latest version of my status report web page.  It can be 
found at:

http://members.cox.net/tmolina/kernprobs/status.html

I've seen a lot of positive feedback for Martin's proposal to create a 
bugzilla for kernel bug reports so this is likely to be my last formal 
posting on this subject.  I intend to enter these as the "seed" bug 
reports for his effort, so any comment on this is welcome.  

                               2.5 Kernel Problem Reports as of 22 Oct
   Status                 Discussion  Problem Title

   open                   04 Oct 2002 AIC7XXX boot failure
   1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356254615324&w=2

--------------------------------------------------------------------------
   open                   05 Oct 2002 oops in lock_get_status
   2. http://marc.theaimsgroup.com/?l=linux-kernel&m=103244657605155&w=2

--------------------------------------------------------------------------   
   open                   21 Oct 2002 problems loading/unloading ide-scsi 
                                      modules
   3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103446296810822&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 IDE problems on prePCI
   4. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 USB Mass Storage problems
   5. http://marc.theaimsgroup.com/?l=linux-kernel&m=103404393623200&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 init_irq() function doing unsafe 
                                      things inside ide_lock
   6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103316967724891&w=2

--------------------------------------------------------------------------
   open                   04 Oct 2002 register_console() called in illegal 
                                      context
   7. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 eata2x_detect() calls port_detect() 
                                      under driver_lock
   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281310122580&w=2

--------------------------------------------------------------------------
   open                   04 Oct 2002 sym_eh_handler does down(&ep->sem) 
                                      and might sleep
   9. http://marc.theaimsgroup.com/?l=linux-kernel&m=103372067026942&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 illegal sleeping function called 
                                      from acpi_os_wait_semaphore()
  10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103404677824885&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 migration_thread atomicity error
  11. http://marc.theaimsgroup.com/?l=linux-kernel&m=103408159014496&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 snd_via8233 atomicity error
  12. http://marc.theaimsgroup.com/?l=linux-kernel&m=103410375210315&w=2

--------------------------------------------------------------------------
   open                   19 Oct 2002 atomicity error in 
                                      sound/pci/via82xx.c
  13. http://marc.theaimsgroup.com/?l=linux-kernel&m=103459664021147&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 scheduling while atomic in 
                                      autofs4_root_lookup
  14. http://marc.theaimsgroup.com/?l=linux-kernel&m=103426998326969&w=2

--------------------------------------------------------------------------
   open                   14 Oct 2002 atomicity error in 
                                      drivers/net/ppp_async.c
  15. http://marc.theaimsgroup.com/?l=linux-kernel&m=103456920802806&w=2

--------------------------------------------------------------------------
   open                   14 Oct 2002 atomicity error in bond_enslave
  16. http://marc.theaimsgroup.com/?l=linux-kernel&m=103462775624793&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 swsusp atomicity error
  17. http://marc.theaimsgroup.com/?l=linux-kernel&m=103489821623783&w=2

--------------------------------------------------------------------------
   possible fix available 19 Oct 2002 atomicity error in snd_pcm/emufx.c
  18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103502805324053&w=2

--------------------------------------------------------------------------
   open                   03 Oct 2002 ACPI Mutex failure
  19. http://marc.theaimsgroup.com/?l=linux-kernel&m=103369523011536&w=2

--------------------------------------------------------------------------
   open                   16 Oct 2002 initrd breakage
  20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103364305822611&w=2

--------------------------------------------------------------------------
   open                   05 Oct 2002 2.5.x and 8250 UART problems
  21. http://marc.theaimsgroup.com/?l=linux-kernel&m=103383019409525&w=2

--------------------------------------------------------------------------
   open                   19 Oct 2002 mouse/keyboard freeze in X
  22. http://marc.theaimsgroup.com/?l=linux-kernel&m=103441624616220&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 bug related to virtual consoles
  23. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403138113853&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 oops in kmem_cache_create
  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403423716317&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 USB Hub failure
  25. http://marc.theaimsgroup.com/?l=linux-kernel&m=103402696809279&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 boot problem on 440GX
  26. http://marc.theaimsgroup.com/?l=linux-kernel&m=103399796506960&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 oops in run_timer_tasklet
  27. http://marc.theaimsgroup.com/?l=linux-kernel&m=103393743102152&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 oops while running kjournald
  28. http://marc.theaimsgroup.com/?l=linux-kernel&m=103408191314814&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 64GB highmem BUG()
  29. http://marc.theaimsgroup.com/?l=linux-kernel&m=103399745406334&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 Attempt to release TCP socket errors
  30. http://marc.theaimsgroup.com/?l=linux-kernel&m=103409524231641&w=2

--------------------------------------------------------------------------
   closed                 09 Oct 2002 raid 0/1 problems in 2.5
  31. http://marc.theaimsgroup.com/?l=linux-kernel&m=103414903003887&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 raid5 hangs system
  32. http://marc.theaimsgroup.com/?l=linux-kernel&m=103495428502729&w=2

--------------------------------------------------------------------------
   open                   06 Oct 2002 analog joystick oops
  33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103393598801189&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 DRI not working
  34. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403348315804&w=2

--------------------------------------------------------------------------
   open                   10 Oct 2002 keyboard generates bogus key results
  35. http://marc.theaimsgroup.com/?l=linux-kernel&m=103423327423623&w=2

--------------------------------------------------------------------------
   closed                 19 Oct 2002 no mouse wheel
  36. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351918416613&w=2

--------------------------------------------------------------------------
   open                   10 Oct 2002 PCMCIA trouble
  37. http://marc.theaimsgroup.com/?l=linux-kernel&m=103420230730597&w=2

--------------------------------------------------------------------------
   open                   13 Oct 2002 apm hangs instead of suspending
  38. http://marc.theaimsgroup.com/?l=linux-kernel&m=103454656623320&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 tcp packets lost
  39. http://marc.theaimsgroup.com/?l=linux-kernel&m=103429736523667&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 shutdown problems in 
                                      driverfs_remove_file
  40. http://marc.theaimsgroup.com/?l=linux-kernel&m=103443278524877&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 broke ARM zImage/Image
  41. http://marc.theaimsgroup.com/?l=linux-kernel&m=103442271819464&w=2

--------------------------------------------------------------------------
   open                   20 Oct 2002 loadlin boot failure
  42. http://marc.theaimsgroup.com/?l=linux-kernel&m=103444415832048&w=2

--------------------------------------------------------------------------
   open                   13 Oct 2002 dual pointing device problem on 
                                      laptop
  43. http://marc.theaimsgroup.com/?l=linux-kernel&m=103454188820088&w=2

--------------------------------------------------------------------------
   open                   14 Oct 2002 fbcon oops
  44. http://marc.theaimsgroup.com/?l=linux-kernel&m=103458863514865&w=2

--------------------------------------------------------------------------
   open                   14 Oct 2002 ACPI/Suspend with an Acer Travelmate 
                                      350
  45. http://marc.theaimsgroup.com/?l=linux-kernel&m=103463029127750&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 nfsd oops in auth_domain function
  46. http://marc.theaimsgroup.com/?l=linux-kernel&m=103462971527133&w=2

--------------------------------------------------------------------------
   open                   15 Oct 2002 BUG in put_device during rmmod
  47. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470283114965&w=2

--------------------------------------------------------------------------
   open                   15 Oct 2002 BUG in kmem_cache_alloc_one_tail on 
                                          2.5.42
  48. http://marc.theaimsgroup.com/?l=linux-kernel&m=103472220913410&w=2

--------------------------------------------------------------------------
   open                   15 Oct 2002 oops stopping serial
  49. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470900729987&w=2

--------------------------------------------------------------------------
   open                   15 Oct 2002 kernel hangs executing rpcinfo
  50. http://marc.theaimsgroup.com/?l=linux-kernel&m=103462345019675&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 reboot kills Dell Latitude keyboard
  51. http://marc.theaimsgroup.com/?l=linux-kernel&m=103484425027884&w=2

--------------------------------------------------------------------------
   open                   19 Oct 2002 power down fails after 2.5.41
  52. http://marc.theaimsgroup.com/?l=linux-kernel&m=103479527518536&w=2

--------------------------------------------------------------------------
   open                   16 Oct 2002 ACPI/Sb16 IRQ conflict
  53. http://marc.theaimsgroup.com/?l=linux-kernel&m=103480163226174&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 oops booting via ide controller
  54. http://marc.theaimsgroup.com/?l=linux-kernel&m=103480082625264&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 IDE not powered down on shutdown
  55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2

--------------------------------------------------------------------------
   closed                 20 Oct 2002 scsi/raid-related smp boot crash
  56. http://marc.theaimsgroup.com/?l=linux-kernel&m=103485010600696&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 nfs-related oops
  57. http://marc.theaimsgroup.com/?l=linux-kernel&m=103477312121275&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 neofb oops on shutdown
  58. http://marc.theaimsgroup.com/?l=linux-kernel&m=103485950708944&w=2

--------------------------------------------------------------------------
   open                   17 Oct 2002 oops inserting xircom_cb network 
                                      card
  59. http://marc.theaimsgroup.com/?l=linux-kernel&m=103474343128893&w=2

--------------------------------------------------------------------------
   open                   20 Oct 2002 usb-related boot hang
  60. http://marc.theaimsgroup.com/?l=linux-kernel&m=103463093028435&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 io-apic bug and spinlock deadlock
  61. http://marc.theaimsgroup.com/?l=linux-kernel&m=103482589715521&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 buslogic scsi broke
  62. http://marc.theaimsgroup.com/?l=linux-kernel&m=103496938421117&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 color problem with atyfb
  63. http://marc.theaimsgroup.com/?l=linux-kernel&m=103424151129857&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 ipv4 /proc/net/route bug
  64. http://marc.theaimsgroup.com/?l=linux-kernel&m=103497845730726&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 crash with shared page table
  65. http://marc.theaimsgroup.com/?l=linux-kernel&m=103499186007896&w=2

--------------------------------------------------------------------------
   open                   18 Oct 2002 qlogic 2x00 driver broke
  66. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470985631070&w=2

--------------------------------------------------------------------------
   open                   19 Oct 2002 tcq causes filesystem corruption
  67. http://marc.theaimsgroup.com/?l=linux-kernel&m=103498823305987&w=2

--------------------------------------------------------------------------
   open                   19 Oct 2002 ncr adaptor doesn't see devices
  68. http://marc.theaimsgroup.com/?l=linux-kernel&m=103506893016255&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 ide-cd module broke
  69. http://marc.theaimsgroup.com/?l=linux-kernel&m=103508472223894&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 unable to eject zip disk
  70. http://marc.theaimsgroup.com/?l=linux-kernel&m=103523397807029&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 isdn badly broken
  71. http://marc.theaimsgroup.com/?l=linux-kernel&m=103513416515540&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 ide hangs on boot
  72. http://marc.theaimsgroup.com/?l=linux-kernel&m=103515327029718&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 scsi hang on shutdown
  73. http://marc.theaimsgroup.com/?l=linux-kernel&m=103504174230947&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 oops in ieee1394
  74. http://marc.theaimsgroup.com/?l=linux-kernel&m=103519819428268&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 oops on boot in parport_pc module
  75. http://marc.theaimsgroup.com/?l=linux-kernel&m=103524170815346&w=2

--------------------------------------------------------------------------
   open                   21 Oct 2002 ZONE_NORMAL exhaustion (dcache slab)
  76. http://marc.theaimsgroup.com/?l=linux-kernel&m=103523368106684&w=2

--------------------------------------------------------------------------
   open                   22 Oct 2002 2.5.44 fs corruption
  77. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532467828806&w=2

--------------------------------------------------------------------------
   open                   22 Oct 2002 CS4236B stopping working as of 
                                      2.5.44
  78. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532492529636&w=2

--------------------------------------------------------------------------
   open                   22 Oct 2002 2.5.44-mm1 numa-q panic on boot
  79. http://marc.theaimsgroup.com/?l=linux-kernel&m=103533122402278&w=2

--------------------------------------------------------------------------
   open                   22 Oct 2002 poisoned oops unmounting ramfs
  80. http://marc.theaimsgroup.com/?l=linux-kernel&m=103530750609277&w=2

--------------------------------------------------------------------------

