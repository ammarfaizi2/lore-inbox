Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbVKWXwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbVKWXwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVKWXrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:41922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751340AbVKWXqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:40 -0500
Date: Wed, 23 Nov 2005 15:44:15 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       jwboyer@gmail.com
Subject: [patch 04/22] Add more SCM trees to MAINTAINERS
Message-ID: <20051123234415.GE527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-more-scm-trees-to-maintainers.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@gmail.com>

Greg requested a patch to update MAINTAINERS with more SCM entries.
The patch below is what I've found so far.

Signed-off-by: Josh Boyer <jwboyer@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 MAINTAINERS |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- usb-2.6.orig/MAINTAINERS
+++ usb-2.6/MAINTAINERS
@@ -227,6 +227,7 @@ AGPGART DRIVER
 P:	Dave Jones
 M:	davej@codemonkey.org.uk
 W:	http://www.codemonkey.org.uk/projects/agp/
+T:	git kernel.org:/pub/scm/linux/kernel/git/davej/agpgart.git
 S:	Maintained
 
 AHA152X SCSI DRIVER
@@ -384,6 +385,7 @@ P:	David Woodhouse
 M:	dwmw2@infradead.org
 L:	linux-audit@redhat.com
 W:	http://people.redhat.com/sgrubb/audit/
+T:	git kernel.org:/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git
 S:	Maintained
 
 AX.25 NETWORK LAYER
@@ -432,6 +434,7 @@ L:	bluez-devel@lists.sf.net
 W:	http://bluez.sf.net
 W:	http://www.bluez.org
 W:	http://www.holtmann.org/linux/bluetooth/
+T:	git kernel.org:/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
 S:	Maintained
 
 BLUETOOTH RFCOMM LAYER
@@ -547,6 +550,7 @@ P:	Steve French
 M:	sfrench@samba.org
 L:	samba-technical@lists.samba.org
 W:	http://us1.samba.org/samba/Linux_CIFS_client.html
+T:	git kernel.org:/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
 S:	Supported	
 
 CIRRUS LOGIC GENERIC FBDEV DRIVER
@@ -608,6 +612,7 @@ P:	Dave Jones
 M:	davej@codemonkey.org.uk
 L:	cpufreq@lists.linux.org.uk
 W:	http://www.codemonkey.org.uk/projects/cpufreq/
+T:	git kernel.org/pub/scm/linux/kernel/davej/cpufreq.git
 S:	Maintained
 
 CPUID/MSR DRIVER
@@ -641,6 +646,7 @@ M:	herbert@gondor.apana.org.au
 P:	David S. Miller
 M:	davem@davemloft.net
 L:	linux-crypto@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
 S:	Maintained
 
 CYBERPRO FB DRIVER
@@ -1185,6 +1191,7 @@ P:	Bartlomiej Zolnierkiewicz
 M:	B.Zolnierkiewicz@elka.pw.edu.pl
 L:	linux-kernel@vger.kernel.org
 L:	linux-ide@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
 S:	Maintained
 
 IDE/ATAPI CDROM DRIVER
@@ -1279,6 +1286,7 @@ P:	Vojtech Pavlik
 M:	vojtech@suse.cz
 L:	linux-input@atrey.karlin.mff.cuni.cz
 L:	linux-joystick@atrey.karlin.mff.cuni.cz
+T:	git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained
 
 INOTIFY
@@ -1392,6 +1400,7 @@ P:	Kai Germaschewski
 M:	kai.germaschewski@gmx.de
 L:	isdn4linux@listserv.isdn4linux.de
 W:	http://www.isdn4linux.de
+T:	git kernel.org:/pub/scm/linux/kernel/kkeil/isdn-2.6.git
 S:	Maintained
 
 ISDN SUBSYSTEM (Eicon active card driver)
@@ -1420,6 +1429,7 @@ P:	Dave Kleikamp
 M:	shaggy@austin.ibm.com
 L:	jfs-discussion@lists.sourceforge.net
 W:	http://jfs.sourceforge.net/
+T:	git kernel.org:/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git
 S:	Supported
 
 KCONFIG
@@ -1534,6 +1544,7 @@ P:	Paul Mackerras
 M:	paulus@samba.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
 S:	Supported
 
 LINUX FOR POWER MACINTOSH
@@ -1601,6 +1612,7 @@ P:	Chris Wright
 M:	chrisw@osdl.org
 L:	linux-security-module@wirex.com
 W:	http://lsm.immunix.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git
 S:	Supported
 
 LM83 HARDWARE MONITOR DRIVER
@@ -1816,6 +1828,7 @@ M:	yoshfuji@linux-ipv6.org
 P:	Patrick McHardy
 M:	kaber@coreworks.de
 L:	netdev@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/davem/net-2.6.git
 S:	Maintained
 
 IPVS
@@ -1867,6 +1880,7 @@ M:	aia21@cantab.net
 L:	linux-ntfs-dev@lists.sourceforge.net
 L:	linux-kernel@vger.kernel.org
 W:	http://linux-ntfs.sf.net/
+T:	git kernel.org:/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git
 S:	Maintained
 
 NVIDIA (RIVA) FRAMEBUFFER DRIVER
@@ -2390,6 +2404,7 @@ P:	Anton Blanchard
 M:	anton@samba.org
 L:	sparclinux@vger.kernel.org
 L:	ultralinux@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git
 S:	Maintained
 
 SHARP LH SUPPORT (LH7952X & LH7A40X)
@@ -2528,6 +2543,7 @@ P:      Adrian Bunk
 M:      trivial@kernel.org
 L:      linux-kernel@vger.kernel.org
 W:      http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/
+T:      git kernel.org:/pub/scm/linux/kernel/git/bunk/trivial.git
 S:      Maintained
 
 TMS380 TOKEN-RING NETWORK DRIVER
@@ -2861,6 +2877,7 @@ P:      Latchesar Ionkov
 M:      lucho@ionkov.net
 L:      v9fs-developer@lists.sourceforge.net
 W:      http://v9fs.sf.net
+T:      git kernel.org:/pub/scm/linux/kernel/ericvh/v9fs-devel.git
 S:      Maintained
 
 VIDEO FOR LINUX

--
