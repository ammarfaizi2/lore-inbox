Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSE2EMg>; Wed, 29 May 2002 00:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSE2EMf>; Wed, 29 May 2002 00:12:35 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:9412
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S314101AbSE2EMX>; Wed, 29 May 2002 00:12:23 -0400
Message-ID: <3CF4550A.BD6E725A@rogers.com>
Date: Wed, 29 May 2002 00:11:54 -0400
From: John Kacur <jkacur@rogers.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH][trivial documentation]linuxdoc->tldp
Content-Type: multipart/mixed;
 boundary="------------32060755B669D2F3BD0005DF"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.101.229.155] using ID <jkacur@rogers.com> at Wed, 29 May 2002 00:12:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------32060755B669D2F3BD0005DF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch was made against linux-2.4.18 with patch-2.4.19-pre9 applied.
Purpose: Update the documentation to reflect the fact that
www.linux.org is now www.tldp.org
--------------32060755B669D2F3BD0005DF
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -ur Documentation.orig/Configure.help Documentation/Configure.help
--- Documentation.orig/Configure.help	Tue May 28 23:47:39 2002
+++ Documentation/Configure.help	Tue May 28 23:52:04 2002
@@ -31,7 +31,7 @@
 #
 # Information about what a kernel is, what it does, how to patch and
 # compile it and much more is contained in the Kernel-HOWTO, available
-# at <http://www.linuxdoc.org/docs.html#howto>. Before you start
+# at <http://www.tldp.org/docs.html#howto>. Before you start
 # compiling, make sure that you have the necessary versions of all
 # programs and libraries required to compile and run this kernel; they
 # are listed in the <file:Documentation/Changes>. Make sure to read the
@@ -136,7 +136,7 @@
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you don't know what to do here, say N.
 
@@ -592,7 +592,7 @@
   topics, is contained in <file:Documentation/ide.txt>. For detailed
   information about hard drives, consult the Disk-HOWTO and the
   Multi-Disk-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   To fine-tune ATA/IDE drive/interface parameters for improved
   performance, look for the hdparm package at
@@ -625,7 +625,7 @@
   If you are unsure, then just choose the Enhanced IDE/MFM/RLL driver
   instead of this one. For more detailed information, read the
   Disk-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 Use old disk-only driver on primary interface
 CONFIG_BLK_DEV_HD_IDE
@@ -1793,7 +1793,7 @@
 
   More information about Software RAID on Linux is contained in the
   Software RAID mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. There you will also learn
+  <http://www.tldp.org/docs.html#howto>. There you will also learn
   where to get the supporting user space utilities raidtools.
 
   If unsure, say N.
@@ -1821,7 +1821,7 @@
 
   Information about Software RAID on Linux is contained in the
   Software-RAID mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. There you will also
+  <http://www.tldp.org/docs.html#howto>. There you will also
   learn where to get the supporting user space utilities raidtools.
 
   If you want to compile this as a module ( = code which can be
@@ -1843,7 +1843,7 @@
 
   Information about Software RAID on Linux is contained in the
   Software-RAID mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  There you will also
+  <http://www.tldp.org/docs.html#howto>.  There you will also
   learn where to get the supporting user space utilities raidtools.
 
   If you want to use such a RAID-1 set, say Y. This code is also
@@ -1866,7 +1866,7 @@
 
   Information about Software RAID on Linux is contained in the
   Software-RAID mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. There you will also
+  <http://www.tldp.org/docs.html#howto>. There you will also
   learn where to get the supporting user space utilities raidtools.
 
   If you want to use such a RAID-4/RAID-5 set, say Y. This code is
@@ -2355,7 +2355,7 @@
 
   For a general introduction to Linux networking, it is highly
   recommended to read the NET-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 Socket filtering
 CONFIG_FILTER
@@ -3198,7 +3198,7 @@
   Say Y here if you have dumb serial boards other than the four
   standard COM 1/2/3/4 ports. This may happen if you have an AST
   FourPort, Accent Async, Boca (read the Boca mini-HOWTO, available
-  from <http://www.linuxdoc.org/docs.html#howto>), or other custom
+  from <http://www.tldp.org/docs.html#howto>), or other custom
   serial port hardware which acts similar to standard serial port
   hardware. If you only use the standard COM 1/2/3/4 ports, you can
   say N here to save some memory. You can also say Y if you have an
@@ -3420,7 +3420,7 @@
   VESA. If you have PCI, say Y, otherwise N.
 
   The PCI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, contains valuable
+  <http://www.tldp.org/docs.html#howto>, contains valuable
   information about which PCI hardware does work under Linux and which
   doesn't.
 
@@ -3432,7 +3432,7 @@
   VESA. If you have PCI, say Y, otherwise N.
 
   The PCI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, contains valuable
+  <http://www.tldp.org/docs.html#howto>, contains valuable
   information about which PCI hardware does work under Linux and which
   doesn't.
 
@@ -3444,7 +3444,7 @@
   VESA. If you have PCI, say Y, otherwise N.
 
   The PCI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, contains valuable
+  <http://www.tldp.org/docs.html#howto>, contains valuable
   information about which PCI hardware does work under Linux and which
   doesn't.
 
@@ -3699,7 +3699,7 @@
   To use your PC-cards, you will need supporting software from David
   Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
   for location).  Please also read the PCMCIA-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -3753,12 +3753,12 @@
   and some programs won't run unless you say Y here. In particular, if
   you want to run the DOS emulator dosemu under Linux (read the
   DOSEMU-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>), you'll need to say Y
+  <http://www.tldp.org/docs.html#howto>), you'll need to say Y
   here.
 
   You can find documentation about IPC with "info ipc" and also in
   section 6.4 of the Linux Programmer's Guide, available from
-  <http://www.linuxdoc.org/docs.html#guide>.
+  <http://www.tldp.org/docs.html#guide>.
 
 BSD Process Accounting
 CONFIG_BSD_PROCESS_ACCT
@@ -3827,7 +3827,7 @@
   want to say Y here.
 
   Information about ELF is contained in the ELF HOWTO available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you find that after upgrading from Linux kernel 1.2 and saying Y
   here, you still can't run any ELF binaries (they just crash), then
@@ -3887,7 +3887,7 @@
   programs that need an interpreter to run like Java, Python or
   Emacs-Lisp. It's also useful if you often run DOS executables under
   the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>). Once you have
+  <http://www.tldp.org/docs.html#howto>). Once you have
   registered such a binary class with the kernel, you can start one of
   those programs simply by typing in its name at a shell prompt; Linux
   will automatically feed it to the correct interpreter.
@@ -5111,7 +5111,7 @@
 
   For an excellent introduction to Linux networking, please read the
   NET-3-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This option is also necessary if you want to use the full power of
   term (term is a program which gives you almost full Internet
@@ -5433,7 +5433,7 @@
   Novell client ncpfs (available from
   <ftp://platan.vc.cvut.cz/pub/linux/ncpfs/>) or from
   within the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>).  In order
+  available from <http://www.tldp.org/docs.html#howto>).  In order
   to do the former, you'll also have to say Y to "NCP file system
   support", below.
 
@@ -5446,7 +5446,7 @@
   <ftp://ibiblio.org/pub/Linux/system/network/daemons/> or
   mars_nwe from <ftp://www.compu-art.de/mars_nwe/>. For more
   information, read the IPX-HOWTO available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   General information about how to connect Linux, Windows machines and
   Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.
@@ -5467,7 +5467,7 @@
   same address). The way this is done is to create a virtual internal
   "network" inside your box and to assign an IPX address to this
   network. Say Y here if you want to do this; read the IPX-HOWTO at
-  <http://www.linuxdoc.org/docs.html#howto> for details.
+  <http://www.tldp.org/docs.html#howto> for details.
 
   The full internal IPX network enables you to allocate sockets on
   different virtual nodes of the internal network. This is done by
@@ -5502,7 +5502,7 @@
   space programs lwared or mars_nwe for the server side).
 
   Say Y here if you have use for SPX; read the IPX-HOWTO at
-  <http://www.linuxdoc.org/docs.html#howto> for details.
+  <http://www.tldp.org/docs.html#howto> for details.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -5582,7 +5582,7 @@
   General information about how to connect Linux, Windows machines and
   Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
   NET-3-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, contains valuable
+  <http://www.tldp.org/docs.html#howto>, contains valuable
   information as well.
 
   This driver is also available as a module ( = code which can be
@@ -5671,7 +5671,7 @@
 CONFIG_HAMRADIO
   If you want to connect your Linux box to an amateur radio, answer Y
   here. You want to read <http://www.tapr.org/tapr/html/pkthome.html> and
-  the AX25-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>.
+  the AX25-HOWTO, available from <http://www.tldp.org/docs.html#howto>.
 
   Note that the answer to this question won't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -5695,7 +5695,7 @@
   Information about where to get supporting software for Linux amateur
   radio as well as information about how to configure an AX.25 port is
   contained in the AX25-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. You might also want to
+  <http://www.tldp.org/docs.html#howto>. You might also want to
   check out the file <file:Documentation/networking/ax25.txt> in the
   kernel source. More information about digital amateur radio in
   general is on the WWW at
@@ -5732,7 +5732,7 @@
   A comprehensive listing of all the software for Linux amateur radio
   users as well as information about how to configure an AX.25 port is
   contained in the AX25-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. You also might want to
+  <http://www.tldp.org/docs.html#howto>. You also might want to
   check out the file <file:Documentation/networking/ax25.txt>. More
   information about digital amateur radio in general is on the WWW at
   <http://www.tapr.org/tapr/html/pkthome.html>.
@@ -5751,7 +5751,7 @@
   A comprehensive listing of all the software for Linux amateur radio
   users as well as information about how to configure an AX.25 port is
   contained in the AX25-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  You also might want to
+  <http://www.tldp.org/docs.html#howto>.  You also might want to
   check out the file <file:Documentation/networking/ax25.txt>. More
   information about digital amateur radio in general is on the WWW at
   <http://www.tapr.org/tapr/html/pkthome.html>.
@@ -5815,7 +5815,7 @@
   Currently, this driver supports Ottawa PI/PI2, Paccomm/Gracilis
   PackeTwin, and S5SCC/DMA boards. They are detected automatically.
   If you have one of these cards, say Y here and read the AX25-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   This driver can operate multiple boards simultaneously. If you
   compile it as a module (by saying M instead of Y), it will be called
@@ -5841,7 +5841,7 @@
   in order to communicate with other computers. If you want to use
   this, read <file:Documentation/networking/z8530drv.txt> and the
   AX25-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. Also make sure to say Y
+  <http://www.tldp.org/docs.html#howto>. Also make sure to say Y
   to "Amateur Radio AX.25 Level 2" support.
 
   If you want to compile this as a module ( = code which can be
@@ -6128,7 +6128,7 @@
   Note that if your box acts as a bridge, it probably contains several
   Ethernet devices, but the kernel is not able to recognize more than
   one at boot time without help; for details read the Ethernet-HOWTO,
-  available from in <http://www.linuxdoc.org/docs.html#howto>.
+  available from in <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this code as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -6794,7 +6794,7 @@
   If you want to use a SCSI hard disk or the SCSI or parallel port
   version of the IOMEGA ZIP drive under Linux, say Y and read the
   SCSI-HOWTO, the Disk-HOWTO and the Multi-Disk-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. This is NOT for SCSI
+  <http://www.tldp.org/docs.html#howto>. This is NOT for SCSI
   CD-ROMs.
 
   This driver is also available as a module ( = code which can be
@@ -6838,7 +6838,7 @@
 CONFIG_CHR_DEV_ST
   If you want to use a SCSI tape drive under Linux, say Y and read the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, and
+  <http://www.tldp.org/docs.html#howto>, and
   <file:drivers/scsi/README.st> in the kernel source.  This is NOT for
   SCSI CD-ROMs.
 
@@ -6858,7 +6858,7 @@
   tape drives (ADR-x0) that supports the standard SCSI-2 commands for
   tapes (QIC-157) and can be driven by the standard driver st.
   For more information, you may have a look at the SCSI-HOWTO
-  <http://www.linuxdoc.org/docs.html#howto>  and
+  <http://www.tldp.org/docs.html#howto>  and
   <file:drivers/scsi/README.osst>  in the kernel source.
   More info on the OnStream driver may be found on
   <http://linux1.onstream.nl/test/>
@@ -6875,7 +6875,7 @@
 CONFIG_BLK_DEV_SR
   If you want to use a SCSI CD-ROM under Linux, say Y and read the
   SCSI-HOWTO and the CD-ROM-HOWTO at
-  <http://www.linuxdoc.org/docs.html#howto>. Also make sure to say Y
+  <http://www.tldp.org/docs.html#howto>. Also make sure to say Y
   or M to "ISO 9660 CD-ROM file system support" later.
 
   This driver is also available as a module ( = code which can be
@@ -6998,7 +6998,7 @@
   must be manually specified in this case.
 
   It is explained in section 3.3 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. You might also want to
+  <http://www.tldp.org/docs.html#howto>. You might also want to
   read the file <file:drivers/scsi/README.aha152x>.
 
   This driver is also available as a module ( = code which can be
@@ -7010,7 +7010,7 @@
 CONFIG_SCSI_AHA1542
   This is support for a SCSI host adapter.  It is explained in section
   3.4 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Note that Trantor was
+  <http://www.tldp.org/docs.html#howto>.  Note that Trantor was
   purchased by Adaptec, and some former Trantor products are being
   sold under the Adaptec name.  If it doesn't work out of the box, you
   may have to change some settings in <file:drivers/scsi/aha1542.h>.
@@ -7024,7 +7024,7 @@
 CONFIG_SCSI_AHA1740
   This is support for a SCSI host adapter.  It is explained in section
   3.5 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
+  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/aha1740.h>.
 
@@ -7120,7 +7120,7 @@
   configuration options. You should read
   <file:drivers/scsi/aic7xxx_old/README.aic7xxx> at a minimum before
   contacting the maintainer with any questions.  The SCSI-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>, can also
+  available from <http://www.tldp.org/docs.html#howto>, can also
   be of great help.
 
   If you want to compile this driver as a module ( = code which can be
@@ -7214,7 +7214,7 @@
 CONFIG_SCSI_BUSLOGIC
   This is support for BusLogic MultiMaster and FlashPoint SCSI Host
   Adapters. Consult the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, and the files
+  <http://www.tldp.org/docs.html#howto>, and the files
   <file:drivers/scsi/README.BusLogic> and
   <file:drivers/scsi/README.FlashPoint> for more information. If this
   driver does not work correctly without modification, please contact
@@ -7251,7 +7251,7 @@
 CONFIG_SCSI_DTC3280
   This is support for DTC 3180/3280 SCSI Host Adapters.  Please read
   the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, and the file
+  <http://www.tldp.org/docs.html#howto>, and the file
   <file:drivers/scsi/README.dtc3x80>.
 
   This driver is also available as a module ( = code which can be
@@ -7268,7 +7268,7 @@
   Note that this driver is obsolete; if you have one of the above
   SCSI Host Adapters, you should normally say N here and Y to "EATA
   ISA/EISA/PCI support", below.  Please read the SCSI-HOWTO, available
-  from <http://www.linuxdoc.org/docs.html#howto>.
+  from <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -7282,7 +7282,7 @@
   host adapters could also use this driver but are discouraged from
   doing so, since this driver only supports hard disks and lacks
   numerous features.  You might want to have a look at the SCSI-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -7296,7 +7296,7 @@
   information about this hardware.  If the driver doesn't work out of
   the box, you may have to change some settings in
   <file: drivers/scsi/u14-34f.c>.  Read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Note that there is also
+  <http://www.tldp.org/docs.html#howto>.  Note that there is also
   another driver for the same hardware: "UltraStor SCSI support",
   below.  You should say Y to both only if you want 24F support as
   well.
@@ -7331,7 +7331,7 @@
   other adapters based on the Future Domain chipsets (Quantum
   ISA-200S, ISA-250MG; Adaptec AHA-2920A; and at least one IBM board).
   It is explained in section 3.7 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   NOTE: Newer Adaptec AHA-2920C boards use the Adaptec AIC-7850 chip
   and should use the aic7xxx driver ("Adaptec AIC7xxx chipset SCSI
@@ -7361,7 +7361,7 @@
   This is the generic NCR family of SCSI controllers, not to be
   confused with the NCR 53c7 or 8xx controllers.  It is explained in
   section 3.8 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
+  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/g_NCR5380.h>.
 
@@ -7408,7 +7408,7 @@
   This is a driver for the 53c7 and 8xx NCR family of SCSI
   controllers, not to be confused with the NCR 5380 controllers.  It
   is explained in section 3.8 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
+  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/53c7,8xx.h>.  Please read
   <file:drivers/scsi/README.ncr53c7xx> for the available boot time
@@ -7767,7 +7767,7 @@
 CONFIG_SCSI_INITIO
   This is support for the Initio 91XXU(W) SCSI host adapter.  Please
   read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -7778,7 +7778,7 @@
 CONFIG_SCSI_PAS16
   This is support for a SCSI host adapter.  It is explained in section
   3.10 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
+  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/pas16.h>.
 
@@ -7791,7 +7791,7 @@
 CONFIG_SCSI_INIA100
   This is support for the Initio INI-A100U2W SCSI host adapter.
   Please read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -7802,7 +7802,7 @@
 CONFIG_SCSI_PCI2000
   This is support for the PCI2000I EIDE interface card which acts as a
   SCSI host adapter.  Please read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module called pci2000.o ( = code
   which can be inserted in and removed from the running kernel
@@ -7813,7 +7813,7 @@
 CONFIG_SCSI_PCI2220I
   This is support for the PCI2220i EIDE interface card which acts as a
   SCSI host adapter.  Please read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module called pci2220i.o ( = code
   which can be inserted in and removed from the running kernel
@@ -7824,7 +7824,7 @@
 CONFIG_SCSI_PSI240I
   This is support for the PSI240i EIDE interface card which acts as a
   SCSI host adapter.  Please read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module called psi240i.o ( = code
   which can be inserted in and removed from the running kernel
@@ -7844,7 +7844,7 @@
   Information about this driver is contained in
   <file:drivers/scsi/README.qlogicfas>.  You should also read the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -7862,7 +7862,7 @@
 
   Please read the file <file:drivers/scsi/README.qlogicisp>.  You
   should also read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -7897,7 +7897,7 @@
 CONFIG_SCSI_SEAGATE
   These are 8-bit SCSI controllers; the ST-01 is also supported by
   this driver.  It is explained in section 3.9 of the SCSI-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.  If it
+  available from <http://www.tldp.org/docs.html#howto>.  If it
   doesn't work out of the box, you may have to change some settings in
   <file:drivers/scsi/seagate.h>.
 
@@ -7910,7 +7910,7 @@
 CONFIG_SCSI_T128
   This is support for a SCSI host adapter. It is explained in section
   3.11 of the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
+  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/t128.h>.  Note that Trantor was purchased by
   Adaptec, and some former Trantor products are being sold under the
@@ -7926,7 +7926,7 @@
   This is support for the UltraStor 14F, 24F and 34F SCSI-2 host
   adapter family.  This driver is explained in section 3.12 of the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
+  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/ultrastor.h>.
 
@@ -7968,7 +7968,7 @@
 
   You want to read the start of <file:drivers/scsi/eata.c> and the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Note that there is also another driver for the same hardware
   available: "EATA-DMA [Obsolete] (DPT, NEC, AT&T, SNI, AST, Olivetti,
@@ -8009,7 +8009,7 @@
   This is support for the NCR53c406a SCSI host adapter.  For user
   configurable parameters, check out <file:drivers/scsi/NCR53c406a.c>
   in the kernel source.  Also read the SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -8092,7 +8092,7 @@
   This is support for the AM53/79C974 SCSI host adapters.  Please read
   <file:drivers/scsi/README.AM53C974> for details.  Also, the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, is for you.
+  <http://www.tldp.org/docs.html#howto>, is for you.
 
   Note that there is another driver for AM53C974 based adapters:
   "Tekram DC390(T) and Am53/79C974 (PCscsi) SCSI support", above.  You
@@ -8144,7 +8144,7 @@
   For more information about this driver and how to use it you should
   read the file <file:drivers/scsi/README.ppa>.  You should also read
   the SCSI-HOWTO, which is available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If you use this driver,
+  <http://www.tldp.org/docs.html#howto>.  If you use this driver,
   you will still be able to use the parallel port for other tasks,
   such as a printer; it is safe to compile both drivers into the
   kernel.
@@ -8171,7 +8171,7 @@
   For more information about this driver and how to use it you should
   read the file <file:drivers/scsi/README.ppa>.  You should also read
   the SCSI-HOWTO, which is available from
-  <http://www.linuxdoc.org/docs.html#howto>.  If you use this driver,
+  <http://www.tldp.org/docs.html#howto>.  If you use this driver,
   you will still be able to use the parallel port for other tasks,
   such as a printer; it is safe to compile both drivers into the
   kernel.
@@ -8457,7 +8457,7 @@
   telephone line with a modem either via UUCP (UUCP is a protocol to
   forward mail and news between unix hosts over telephone lines; read
   the UUCP-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>) or dialing up a shell
+  <http://www.tldp.org/docs.html#howto>) or dialing up a shell
   account or a BBS, even using term (term is a program which gives you
   almost full Internet connectivity if you have a regular dial up
   shell account on some Internet connected Unix computer. Read
@@ -8477,7 +8477,7 @@
 
   Make sure to read the NET-3-HOWTO. Eventually, you will have to read
   Olaf Kirch's excellent and free book "Network Administrator's
-  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
+  Guide", to be found in <http://www.tldp.org/docs.html#guide>. If
   unsure, say Y.
 
 Dummy net driver support
@@ -8490,7 +8490,7 @@
   thing often comes in handy, the default is Y. It won't enlarge your
   kernel either. What a deal. Read about it in the Network
   Administrator's Guide, available from
-  <http://www.linuxdoc.org/docs.html#guide>.
+  <http://www.tldp.org/docs.html#guide>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -8538,7 +8538,7 @@
   allows you to use SLIP over a regular dial up shell connection. If
   you plan to use SLiRP, make sure to say Y to CSLIP, below. The
   NET-3-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, explains how to
+  <http://www.tldp.org/docs.html#howto>, explains how to
   configure SLIP. Note that you don't need this option if you just
   want to run term (term is a program which gives you almost full
   Internet connectivity if you have a regular dial up shell account on
@@ -8562,7 +8562,7 @@
   <ftp://ibiblio.org/pub/Linux/system/network/serial/>) which
   allows you to use SLIP over a regular dial up shell connection, you
   definitely want to say Y here. The NET-3-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, explains how to configure
+  <http://www.tldp.org/docs.html#howto>, explains how to configure
   CSLIP. This won't enlarge your kernel.
 
 Keepalive and linefill
@@ -8591,7 +8591,7 @@
 
   To use PPP, you need an additional program called pppd as described
   in the PPP-HOWTO, available at
-  <http://www.linuxdoc.org/docs.html#howto>.  Make sure that you have
+  <http://www.tldp.org/docs.html#howto>.  Make sure that you have
   the version of pppd recommended in <file:Documentation/Changes>.
   The PPP option enlarges your kernel by about 16 KB.
 
@@ -8756,7 +8756,7 @@
 
   If you want to use an ISA WaveLAN card under Linux, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. Some more specific
+  <http://www.tldp.org/docs.html#howto>. Some more specific
   information is contained in
   <file:Documentation/networking/wavelan.txt> and in the source code
   <file:drivers/net/wavelan.p.h>.
@@ -8917,7 +8917,7 @@
   To use your PC-cards, you will need supporting software from David
   Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
   for location).  You also want to check out the PCMCIA-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   If unsure, say N.
 
@@ -9068,7 +9068,7 @@
   To use your PC-cards, you will need supporting software from David
   Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
   for location). You also want to check out the PCMCIA-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
 Hermes chipset 802.11b support (Orinoco/Prism2/Symbol cards)
 CONFIG_HERMES
@@ -9122,7 +9122,7 @@
   To use your PC-cards, you will need supporting software from David
   Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
   for location).  You also want to check out the PCMCIA-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   You will also very likely also need the Wireless Tools in order to
   configure your card and that /etc/pcmcia/wireless.opts works:
@@ -9160,7 +9160,7 @@
   To use your PC-cards, you will need supporting software from David
   Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
   for location).  You also want to check out the PCMCIA-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
 Aviator/Raytheon 2.4MHz wireless support
 CONFIG_PCMCIA_RAYCS
@@ -9229,7 +9229,7 @@
 
   If you want to use PLIP, say Y and read the PLIP mini-HOWTO as well
   as the NET-3-HOWTO, both available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Note that the PLIP
+  <http://www.tldp.org/docs.html#howto>.  Note that the PLIP
   protocol has been changed and this PLIP driver won't work together
   with the PLIP support in Linux versions 1.0.x.  This option enlarges
   your kernel by about 8 KB.
@@ -9254,7 +9254,7 @@
   Say Y if you want this and read
   <file:Documentation/networking/eql.txt>.  You may also want to read
   section 6.2 of the NET-3-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10281,7 +10281,7 @@
   If your Linux machine will be connected to an Ethernet and you have
   an Ethernet network interface card (NIC) installed in your computer,
   say Y here and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. You will then also have
+  <http://www.tldp.org/docs.html#howto>. You will then also have
   to say Y to the driver for your particular NIC.
 
   Note that the answer to this question won't directly affect the
@@ -10292,7 +10292,7 @@
 CONFIG_NET_VENDOR_SMC
   If you have a network (Ethernet) card belonging to this class, say Y
   and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Note that the answer to this question doesn't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -10303,7 +10303,7 @@
 CONFIG_WD80x3
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10315,7 +10315,7 @@
 CONFIG_ULTRAMCA
   If you have a network (Ethernet) card of this type and are running
   an MCA based system (PS/2), say Y and read the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10327,7 +10327,7 @@
 CONFIG_ULTRA
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Important: There have been many reports that, with some motherboards
   mixing an SMC Ultra and an Adaptec AHA154x SCSI card (or compatible,
@@ -10346,7 +10346,7 @@
 CONFIG_ULTRA32
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10361,7 +10361,7 @@
   another SMC9192/9194 based chipset.  Say Y if you want it compiled
   into the kernel, and read the file
   <file:Documentation/networking/smc9.txt> and the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10375,7 +10375,7 @@
   with ISA NE2000 cards (they have their own driver, "NE2000/NE1000
   support" below). If you have a PCI NE2000 network (Ethernet) card,
   say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver also works for the following NE2000 clone cards:
     RealTek RTL-8029  Winbond 89C940  Compex RL2000  KTI ET32P2
@@ -10392,7 +10392,7 @@
 CONFIG_NET_VENDOR_RACAL
   If you have a network (Ethernet) card belonging to this class, such
   as the NI5010, NI5210 or NI6210, say Y and read the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   Note that the answer to this question doesn't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -10403,7 +10403,7 @@
 CONFIG_NI5010
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. Note that this is still
+  <http://www.tldp.org/docs.html#howto>. Note that this is still
   experimental code.
 
   This driver is also available as a module ( = code which can be
@@ -10416,7 +10416,7 @@
 CONFIG_NI52
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10428,7 +10428,7 @@
 CONFIG_NI65
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10441,7 +10441,7 @@
   This is a driver for the Fast Ethernet PCI network cards based on
   the RTL8139C+ chips. If you have one of those, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -10454,7 +10454,7 @@
   the RTL8139 chips. If you have one of those, say Y and read
   <file:Documentation/networking/8139too.txt> as well as the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -10488,7 +10488,7 @@
   the SiS 900 and SiS 7016 chips. The SiS 900 core is also embedded in
   SiS 630 and SiS 540 chipsets.  If you have one of those, say Y and
   read the Ethernet-HOWTO, available at
-  <http://www.linuxdoc.org/docs.html#howto>.  Please read
+  <http://www.tldp.org/docs.html#howto>.  Please read
   <file:Documentation/networking/sis900.txt> and comments at the
   beginning of <file:drivers/net/sis900.c> for more information.
 
@@ -10637,7 +10637,7 @@
 CONFIG_LANCE
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. Some LinkSys cards are
+  <http://www.tldp.org/docs.html#howto>. Some LinkSys cards are
   of this type.
 
   If you want to compile this driver as a module ( = code which can be
@@ -10649,7 +10649,7 @@
 CONFIG_SGI_IOC3_ETH
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 National Semiconductor DP83902AV support
 CONFIG_STNIC
@@ -10664,7 +10664,7 @@
 CONFIG_NET_VENDOR_3COM
   If you have a network (Ethernet) card belonging to this class, say Y
   and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Note that the answer to this question doesn't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -10675,7 +10675,7 @@
 CONFIG_EL1
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Also, consider buying a
+  <http://www.tldp.org/docs.html#howto>.  Also, consider buying a
   new card, since the 3c501 is slow, broken, and obsolete: you will
   have problems.  Some people suggest to ping ("man ping") a nearby
   machine every minute ("man cron") when using this card.
@@ -10690,7 +10690,7 @@
 CONFIG_EL2
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10703,7 +10703,7 @@
   Information about this network (Ethernet) card can be found in
   <file:Documentation/networking/3c505.txt>.  If you have a card of
   this type, say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -10715,7 +10715,7 @@
 CONFIG_EL16
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10727,7 +10727,7 @@
 CONFIG_ELMC
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10739,7 +10739,7 @@
 CONFIG_ELMC_II
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10751,7 +10751,7 @@
 CONFIG_EL3
   If you have a network (Ethernet) card belonging to the 3Com
   EtherLinkIII series, say Y and read the Ethernet-HOWTO, available
-  from <http://www.linuxdoc.org/docs.html#howto>.
+  from <http://www.tldp.org/docs.html#howto>.
 
   If your card is not working you may need to use the DOS
   setup disk to disable Plug & Play mode, and to select the default
@@ -10767,7 +10767,7 @@
 CONFIG_3C515
   If you have a 3Com ISA EtherLink XL "Corkscrew" 3c515 Fast Ethernet
   network card, say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -10787,7 +10787,7 @@
   "Hurricane" (3c555/3cSOHO)                           PCI
 
   If you have such a card, say Y and read the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>. More
+  available from <http://www.tldp.org/docs.html#howto>. More
   specific information is in
   <file:Documentation/networking/vortex.txt> and in the comments at
   the beginning of <file:drivers/net/3c59x.c>.
@@ -10803,7 +10803,7 @@
   bus system (that's the way the cards talks to the other components
   of your computer) is ISA (as opposed to EISA, VLB or PCI), say Y.
   Make sure you know the name of your card. Read the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   If unsure, say Y.
 
@@ -10824,7 +10824,7 @@
   support" below.
 
   You might also want to have a look at the Ethernet-HOWTO, available
-  from <http://www.linuxdoc.org/docs.html#howto>(even though ARCnet
+  from <http://www.tldp.org/docs.html#howto>(even though ARCnet
   is not really Ethernet).
 
   This driver is also available as a module ( = code which can be
@@ -10915,7 +10915,7 @@
 CONFIG_E2100
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10928,7 +10928,7 @@
   Support for CS89x0 chipset based Ethernet cards. If you have a
   network (Ethernet) card of this type, say Y and read the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto> as well as
+  <http://www.tldp.org/docs.html#howto> as well as
   <file:Documentation/networking/cs89x0.txt>.
 
   If you want to compile this as a module ( = code which can be
@@ -10941,7 +10941,7 @@
 CONFIG_DEPCA
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto> as well as
+  <http://www.tldp.org/docs.html#howto> as well as
   <file:drivers/net/depca.c>.
 
   If you want to compile this as a module ( = code which can be
@@ -10957,7 +10957,7 @@
   cards. If this is for you, say Y and read
   <file:Documentation/networking/ewrk3.txt> in the kernel source as
   well as the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -10969,7 +10969,7 @@
 CONFIG_SEEQ8005
   This is a driver for the SEEQ 8005 network (Ethernet) card.  If this
   is for you, read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -10981,7 +10981,7 @@
 CONFIG_AT1700
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -10994,7 +10994,7 @@
 CONFIG_FMV18X
   If you have a Fujitsu FMV-181/182/183/184 network (Ethernet) card,
   say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you use an FMV-183 or FMV-184 and it is not working, you may need
   to disable Plug & Play mode of the card.
@@ -11011,7 +11011,7 @@
   driver supports intel i82595{FX,TX} based boards. Note however
   that the EtherExpress PRO/100 Ethernet card has its own separate
   driver.  Please read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11023,7 +11023,7 @@
 CONFIG_EEXPRESS
   If you have an EtherExpress16 network (Ethernet) card, say Y and
   read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Note that the Intel
+  <http://www.tldp.org/docs.html#howto>.  Note that the Intel
   EtherExpress16 card used to be regarded as a very poor choice
   because the driver was very unreliable. We now have a new driver
   that should do better.
@@ -11038,7 +11038,7 @@
 CONFIG_HAMACHI
   If you have a Gigabit Ethernet card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -11050,7 +11050,7 @@
 CONFIG_HPLAN_PLUS
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11062,7 +11062,7 @@
 CONFIG_HPLAN
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11074,7 +11074,7 @@
 CONFIG_HP100
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -11086,7 +11086,7 @@
 CONFIG_NE2000
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Many Ethernet cards
+  <http://www.tldp.org/docs.html#howto>.  Many Ethernet cards
   without a specific driver are compatible with NE2000.
 
   If you have a PCI NE2000 card however, say N here and Y to "PCI
@@ -11122,13 +11122,13 @@
 CONFIG_SK_G16
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 NE/2 (ne2000 MCA version) support
 CONFIG_NE2_MCA
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11169,7 +11169,7 @@
 CONFIG_NET_PCI
   This is another class of network cards which attach directly to the
   bus. If you have one of those, say Y and read the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   Note that the answer to this question doesn't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -11181,7 +11181,7 @@
 CONFIG_PCNET32
   If you have a PCnet32 or PCnetPCI based network (Ethernet) card,
   answer Y here and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11193,7 +11193,7 @@
 CONFIG_AC3200
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11205,7 +11205,7 @@
 CONFIG_LNE390
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11217,7 +11217,7 @@
 CONFIG_NE3210
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  Note that this driver
+  <http://www.tldp.org/docs.html#howto>.  Note that this driver
   will NOT WORK for NE3200 cards as they are completely different.
 
   This driver is also available as a module ( = code which can be
@@ -11230,7 +11230,7 @@
 CONFIG_APRICOT
   If you have a network (Ethernet) controller of this type, say Y and
   read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -11244,7 +11244,7 @@
   These include the DE425, DE434, DE435, DE450 and DE500 models.  If
   you have a network card of this type, say Y and read the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. More specific
+  <http://www.tldp.org/docs.html#howto>. More specific
   information is contained in
   <file:Documentation/networking/de4x5.txt>.
 
@@ -11263,7 +11263,7 @@
   (smc9332dst), you can also try the driver for "Generic DECchip"
   cards, above.  However, most people with a network card of this type
   will say Y here.) Do read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  More specific
+  <http://www.tldp.org/docs.html#howto>.  More specific
   information is contained in 
   <file:Documentation/networking/tulip.txt>.
 
@@ -11295,7 +11295,7 @@
   PCI/EISA Ethernet switch cards. These include the SE-4 and the SE-6
   models.  If you have a network card of this type, say Y and read the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.  More specific
+  <http://www.tldp.org/docs.html#howto>.  More specific
   information is contained in <file:Documentation/networking/dgrs.txt>.
 
   This driver is also available as a module ( = code which can be
@@ -11308,7 +11308,7 @@
 CONFIG_EEPRO100
   If you have an Intel EtherExpress PRO/100 PCI network (Ethernet)
   card, say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11344,7 +11344,7 @@
 CONFIG_ETH16I
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11357,7 +11357,7 @@
   If you have a PCI Ethernet network card based on the ThunderLAN chip
   which is supported by this driver, say Y and read the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Devices currently supported by this driver are Compaq Netelligent,
   Compaq NetFlex and Olicom cards.  Please read the file
@@ -11410,7 +11410,7 @@
 CONFIG_ES3210
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11473,7 +11473,7 @@
   (Ethernet) card, and this is the Linux driver for it. Note that the
   IBM Thinkpad 300 is compatible with the Z-Note and is also supported
   by this driver. Read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 Philips SAA9730 Ethernet support
 CONFIG_LAN_SAA9730
@@ -11487,7 +11487,7 @@
   Cute little network (Ethernet) devices which attach to the parallel
   port ("pocket adapters"), commonly used with laptops. If you have
   one of those, say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to plug a network (or some other) card into the PCMCIA
   (or PC-card) slot of your laptop instead (PCMCIA is the standard for
@@ -11507,7 +11507,7 @@
 CONFIG_ATP
   This is a network (Ethernet) device which attaches to your parallel
   port. Read <file:drivers/net/atp.c> as well as the Ethernet-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>, if you
+  available from <http://www.tldp.org/docs.html#howto>, if you
   want to use this.  If you intend to use this driver, you should have
   said N to the "Parallel printer support", because the two drivers
   don't like each other.
@@ -11522,7 +11522,7 @@
   This is a network (Ethernet) device which attaches to your parallel
   port. Read <file:Documentation/networking/DLINK.txt> as well as the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, if you want to use
+  <http://www.tldp.org/docs.html#howto>, if you want to use
   this. It is possible to have several devices share a single parallel
   port and it is safe to compile the corresponding drivers into the
   kernel.
@@ -11538,7 +11538,7 @@
   This is a network (Ethernet) device which attaches to your parallel
   port. Read <file:Documentation/networking/DLINK.txt> as well as the
   Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, if you want to use
+  <http://www.tldp.org/docs.html#howto>, if you want to use
   this. It is possible to have several devices share a single parallel
   port and it is safe to compile the corresponding drivers into the
   kernel.
@@ -11557,14 +11557,14 @@
   connected to such a Token Ring network and want to use your Token
   Ring card under Linux, say Y here and to the driver for your
   particular card below and read the Token-Ring mini-HOWTO, available
-  from <http://www.linuxdoc.org/docs.html#howto>. Most people can
+  from <http://www.tldp.org/docs.html#howto>. Most people can
   say N here.
 
 IBM Tropic chipset based adapter support
 CONFIG_IBMTR
   This is support for all IBM Token Ring cards that don't use DMA. If
   you have such a beast, say Y and read the Token-Ring mini-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   Warning: this driver will almost definitely fail if more than one
   active Token Ring card is present.
@@ -11581,7 +11581,7 @@
   Wake On Lan, and PCI 100/16/4 adapters.
 
   If you have such an adapter, say Y and read the Token-Ring
-  mini-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>.
+  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11597,7 +11597,7 @@
   This is support for IBM Lanstreamer PCI Token Ring Cards.
 
   If you have such an adapter, say Y and read the Token-Ring
-  mini-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>.
+  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a modules ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11617,7 +11617,7 @@
 
   If you have such an adapter and would like to use it, say Y and
   read the Token-Ring mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Also read the file <file:Documentation/networking/tms380tr.txt> or
   check <http://www.auk.cx/tms380tr/>.
@@ -11682,7 +11682,7 @@
 
   If you have such an adapter and would like to use it, say Y or M and
   read the Token-Ring mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto> and the file
+  <http://www.tldp.org/docs.html#howto> and the file
   <file:Documentation/networking/smctr.txt>.
 
   This driver is also available as a module ( = code which can be
@@ -11697,7 +11697,7 @@
   should use the tms380 driver instead.
 
   If you have such an adapter, say Y and read the Token-Ring
-  mini-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>.
+  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -11884,7 +11884,7 @@
 CONFIG_CD_NO_IDESCSI
   If you have a CD-ROM drive that is neither SCSI nor IDE/ATAPI, say Y
   here, otherwise N. Read the CD-ROM-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Note that the answer to this question doesn't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -12162,7 +12162,7 @@
   usage (also called disk quotas). Currently, it works only for the
   ext2 file system. You need additional software in order to use quota
   support; for details, read the Quota mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. Probably the quota
+  <http://www.tldp.org/docs.html#howto>. Probably the quota
   support is only useful for multi user systems. If unsure, say N.
 
 Memory Technology Device (MTD) support
@@ -14336,7 +14336,7 @@
   by about 44 KB.
 
   The Ext2fs-Undeletion mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, gives information about
+  <http://www.tldp.org/docs.html#howto>, gives information about
   how to retrieve deleted files on ext2fs file systems.
 
   To change the behavior of ext2 file systems, you can use the tune2fs
@@ -14540,7 +14540,7 @@
   driver.  If you have a CD-ROM drive and want to do more with it than
   just listen to audio CDs and watch its LEDs, say Y (and read
   <file:Documentation/filesystems/isofs.txt> and the CD-ROM-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>), thereby
+  available from <http://www.tldp.org/docs.html#howto>), thereby
   enlarging your kernel by about 27 KB; otherwise say N.
 
   If you want to compile this as a module ( = code which can be
@@ -14638,7 +14638,7 @@
   they are compressed; to access compressed MSDOS partitions under
   Linux, you can either use the DOS emulator DOSEMU, described in the
   DOSEMU-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, or try dmsdosfs in
+  <http://www.tldp.org/docs.html#howto>, or try dmsdosfs in
   <ftp://ibiblio.org/pub/Linux/system/filesystems/dosfs/>. If you
   intend to use dosemu with a non-compressed MSDOS partition, say Y
   here) and MSDOS floppies. This means that file access becomes
@@ -14802,7 +14802,7 @@
   programs nfsd and mountd (but does not need to have NFS file system
   support enabled in its kernel). NFS is explained in the Network
   Administrator's Guide, available from
-  <http://www.linuxdoc.org/docs.html#guide>, on its man page: "man
+  <http://www.tldp.org/docs.html#guide>, on its man page: "man
   nfs", and in the NFS-HOWTO.
 
   A superior but less widely used alternative to NFS is provided by
@@ -14865,7 +14865,7 @@
   as well.
 
   Please read the NFS-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   The NFS server is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -15435,7 +15435,7 @@
   works only if the Windows machines use TCP/IP as the underlying
   transport protocol, and not NetBEUI.  For details, read
   <file:Documentation/filesystems/smbfs.txt> and the SMB-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   Note: if you just want your box to act as an SMB *server* and make
   files and printing services available to Windows clients (which need
@@ -15516,7 +15516,7 @@
   to mount NetWare file server volumes and to access them just like
   any other Unix directory.  For details, please read the file
   <file:Documentation/filesystems/ncpfs.txt> in the kernel source and
-  the IPX-HOWTO from <http://www.linuxdoc.org/docs.html#howto>.
+  the IPX-HOWTO from <http://www.tldp.org/docs.html#howto>.
 
   You do not have to say Y here if you want your Linux box to act as a
   file *server* for Novell NetWare clients.
@@ -16201,14 +16201,14 @@
   If you want to include a driver to support Nubus or LC-PDS
   Ethernet cards using an NS8390 chipset or its equivalent, say Y
   and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 Macintosh CS89x0 based Ethernet support
 CONFIG_MAC89x0
   Support for CS89x0 chipset based Ethernet cards.  If you have a
   Nubus or LC-PDS network (Ethernet) card of this type, say Y and
   read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -16221,7 +16221,7 @@
   Support for the onboard AMD 79C940 MACE Ethernet controller used in
   the 660AV and 840AV Macintosh.  If you have one of these Macintoshes
   say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 Macintosh SONIC based Ethernet support (onboard, NuBus, LC, CS)
 CONFIG_MACSONIC
@@ -16229,7 +16229,7 @@
   the onboard Ethernet in many Quadras as well as some LC-PDS,
   a few Nubus and all known Comm Slot Ethernet cards.  If you have
   one of these say Y and read the Ethernet-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -16242,14 +16242,14 @@
   This is the NCR 5380 SCSI controller included on most of the 68030
   based Macintoshes.  If you have one of these say Y and read the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 Macintosh NCR53c9[46] SCSI support
 CONFIG_SCSI_MAC_ESP
   This is the NCR 53c9x SCSI controller found on most of the 68040
   based Macintoshes.  If you have one of these say Y and read the
   SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -16582,7 +16582,7 @@
   box (as opposed to using a serial printer; if the connector at the
   printer has 9 or 25 holes ["female"], then it's serial), say Y.
   Also read the Printing-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   It is possible to share one parallel port among several devices
   (e.g. printer and ZIP drive) and it is safe to compile the
@@ -16927,7 +16927,7 @@
   MouseSystem or Microsoft mouse (made by Logitech) that plugs into a
   COM port (rectangular with 9 or 25 pins). These people say N here.
   If you have something else, read the Busmouse-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. This HOWTO contains
+  <http://www.tldp.org/docs.html#howto>. This HOWTO contains
   information about all non-serial mice, not just bus mice.
 
   If you have a laptop, you either have to check the documentation or
@@ -16944,7 +16944,7 @@
   generally a round connector with 9 pins. Note that the newer mice
   made by Logitech don't use the Logitech protocol anymore; for those,
   you don't need this option.  You want to read the Busmouse-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -16964,7 +16964,7 @@
 
   Although PS/2 mice are not technically bus mice, they are explained
   in detail in the Busmouse-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   When using a PS/2 mouse, you can get problems if you want to use the
   mouse both on the Linux console and under X. Using the "-R" option
@@ -16977,7 +16977,7 @@
   This is a certain kind of PS/2 mouse used on the TI Travelmate. If
   you are unsure, try first to say N here and come back if the mouse
   doesn't work. Read the Busmouse-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
 PC110 digitizer pad support
 CONFIG_PC110_PAD
@@ -16995,7 +16995,7 @@
   These animals (also called Inport mice) are connected to an
   expansion board using a round connector with 9 pins. If this is what
   you have, say Y and read the Busmouse-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you are unsure, say N and read the HOWTO nevertheless: it will
   tell you what you have. Also be aware that several vendors talk
@@ -17011,7 +17011,7 @@
 CONFIG_ADBMOUSE
   Say Y here if you have this type of bus mouse (4 pin connector) as
   is common on Macintoshes.  You may want to read the Busmouse-HOWTO,
-  available from <http://www.linuxdoc.org/docs.html#howto>.
+  available from <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -17025,7 +17025,7 @@
   most mice by ATI are actually Microsoft busmice; you should say Y to
   "Microsoft busmouse support" above if you have one of those.  Read
   the Busmouse-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -17574,7 +17574,7 @@
   page on the WWW at
   <http://www.cs.utexas.edu/users/kharker/linux-laptop/> and the
   Battery Powered Linux mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   Note that, even if you say N here, Linux on the x86 architecture
   will issue the hlt instruction if nothing is to be done, thereby
@@ -17691,7 +17691,7 @@
   In order to use APM, you will need supporting software. For location
   and more information, read <file:Documentation/pm.txt> and the
   Battery Powered Linux mini-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   This driver does not spin down disk drives (see the hdparm(8)
   manpage ("man 8 hdparm") for that), and it doesn't turn off
@@ -18595,7 +18595,7 @@
   interrupt and DMA channel), because you will be asked for it.
 
   You want to read the Sound-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>. General information about
+  <http://www.tldp.org/docs.html#howto>. General information about
   the modular sound system is contained in the files
   <file:Documentation/sound/Introduction>.  The file
   <file:Documentation/sound/README.OSS> contains some slightly
@@ -19095,7 +19095,7 @@
   Say Y here if you have a Sound Blaster SB32, AWE32-PnP, SB AWE64 or
   similar sound card. See <file:Documentation/sound/README.awe>,
   <file:Documentation/sound/AWE32> and the Soundblaster-AWE
-  mini-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>
+  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>
   for more info.
 
 Gallant Audio Cards (SC-6000 and SC-6600 based)
@@ -23241,7 +23241,7 @@
   some user-space utilities like irattach.  For more information, see
   the file <file:Documentation/networking/irda.txt>.  You also want to
   read the IR-HOWTO, available at
-  <http://www.linuxdoc.org/docs.html#howto>.
+  <http://www.tldp.org/docs.html#howto>.
 
   If you want to exchange bits of data (vCal, vCard) with a PDA, you
   will need to install some OBEX application, such as OpenObex :
diff -ur Documentation.orig/DocBook/sis900.tmpl Documentation/DocBook/sis900.tmpl
--- Documentation.orig/DocBook/sis900.tmpl	Tue May 28 23:47:40 2002
+++ Documentation/DocBook/sis900.tmpl	Tue May 28 23:55:53 2002
@@ -323,8 +323,8 @@
 The 1.06 revision can be found in kernel version later than 2.3.15 and pre-2.2.14, 
 and 1.07 revision can be found in kernel version 2.4.0.
 If you have no prior experience in networking under Linux, please read
-<ULink URL="http://www.linuxdoc.org/">Ethernet HOWTO</ULink> and
-<ULink URL="http://www.linuxdoc.org/">Networking HOWTO</ULink> available from
+<ULink URL="http://www.tldp.org/">Ethernet HOWTO</ULink> and
+<ULink URL="http://www.tldp.org/">Networking HOWTO</ULink> available from
 Linux Documentation Project (LDP).
 </Para>
 
@@ -435,7 +435,7 @@
 Typical values are "10baseT"(twisted-pair 10Mbps Ethernet) or "100baseT"
 (twisted-pair 100Mbps Ethernet). For more information on how to configure 
 network interface, please refer to  
-<ULink URL="http://www.linuxdoc.org/">Networking HOWTO</ULink>.
+<ULink URL="http://www.tldp.org/">Networking HOWTO</ULink>.
 </Para>
 
 <Para>
diff -ur Documentation.orig/kernel-docs.txt Documentation/kernel-docs.txt
--- Documentation.orig/kernel-docs.txt	Tue May 28 23:47:40 2002
+++ Documentation/kernel-docs.txt	Tue May 28 23:57:21 2002
@@ -41,7 +41,7 @@
        
      * Title: "The Linux Kernel"
        Author: David A. Rusling.
-       URL: http://www.linuxdoc.org/LDP/tlk/tlk.html
+       URL: http://www.tldp.org/LDP/tlk/tlk.html
        Keywords: everything!, book.
        Description: On line, 200 pages book describing most aspects of
        the Linux Kernel. Probably, the first reference for beginners.
@@ -57,7 +57,7 @@
        
      * Title: "The Linux Kernel Hackers' Guide"
        Author: Michael K.Johnson and others.
-       URL: http://www.linuxdoc.org/LDP/khg/HyperNews/get/khg.html
+       URL: http://www.tldp.org/LDP/khg/HyperNews/get/khg.html
        Keywords: everything!
        Description: No more Postscript book-like version. Only HTML now.
        Many people have contributed. The interface is similar to web
@@ -277,7 +277,7 @@
        
      * Title: "Linux Kernel Module Programming Guide"
        Author: Ori Pomerantz.
-       URL: http://www.linuxdoc.org/LDP/lkmpg/mpg.html
+       URL: http://www.tldp.org/LDP/lkmpg/mpg.html
        Keywords: modules, GPL book, /proc, ioctls, system calls,
        interrupt handlers .
        Description: Very nice 92 pages GPL book on the topic of modules
diff -ur Documentation.orig/scsi-generic.txt Documentation/scsi-generic.txt
--- Documentation.orig/scsi-generic.txt	Tue May 28 23:47:40 2002
+++ Documentation/scsi-generic.txt	Wed May 29 00:00:41 2002
@@ -30,7 +30,7 @@
 =======================
 The most recent documentation of the sg driver is kept at the Linux
 Documentation Project's (LDP) site: 
-http://www.linuxdoc.org/HOWTO/SCSI-Generic-HOWTO
+http://www.tldp.org/HOWTO/SCSI-Generic-HOWTO
 This describes the sg version 3 driver found in the lk 2.4 series.
 The LDP renders documents in single and multiple page HTML, postscript
 and pdf. This document can also be found at:
@@ -51,7 +51,7 @@
 can be found at the top of the /usr/src/linux/drivers/scsi/sg.c file.
 
 A more general description of the Linux SCSI subsystem of which sg is a 
-part can be found at http://www.linuxdoc.org/HOWTO/SCSI-2.4-HOWTO .
+part can be found at http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO .
 
 
 Example code and utilities
diff -ur Documentation.orig/scsi.txt Documentation/scsi.txt
--- Documentation.orig/scsi.txt	Tue May 28 23:47:39 2002
+++ Documentation/scsi.txt	Wed May 29 00:01:26 2002
@@ -2,7 +2,7 @@
 ============================
 The Linux Documentation Project (LDP) maintains a document describing
 the SCSI subsystem in the Linux kernel (lk) 2.4 series. See:
-http://www.linuxdoc.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
+http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
 and multiple page HTML renderings as well as postscript and pdf.
 It can also be found at http://www.torque.net/scsi/SCSI-2.4-HOWTO .
 
diff -ur Documentation.orig/sound/PAS16 Documentation/sound/PAS16
--- Documentation.orig/sound/PAS16	Tue May 28 23:47:39 2002
+++ Documentation/sound/PAS16	Wed May 29 00:02:52 2002
@@ -71,7 +71,7 @@
   interrupt and DMA channel), because you will be asked for it.
 
   You want to read the Sound-HOWTO, available from
-  http://www.linuxdoc.org/docs.html#howto . General information
+  http://www.tldp.org/docs.html#howto . General information
   about the modular sound system is contained in the files
   Documentation/sound/Introduction. The file
   Documentation/sound/README.OSS contains some slightly outdated but
Only in Documentation: tmp.ld.txt

--------------32060755B669D2F3BD0005DF--

