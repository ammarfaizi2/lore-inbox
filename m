Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTLDTu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTLDTu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:50:29 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:63474 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262707AbTLDTuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:50:21 -0500
Message-ID: <3FCF8E52.7080603@us.ibm.com>
Date: Thu, 04 Dec 2003 14:43:14 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs sitting in the RESOLVED state for more than 28 days
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in RESOLVED state for more than 28 days,
ie, they have fixes, but aren't back in the mainline tree (when they
should move to CLOSED state). If the fixes are back in mainline
already, could the owner close them out? Otherwise, perhaps we
can get those fixes back in?  If the patch has not fixed the problem
then the bug needs to be moved back into the NEW or ASSIGNED state.

Kernel Bug Tracker: http://bugme.osdl.org

273  Other      Modules    bugme-janitors@lists.osdl.org
initrd refuses to build on raid0 system

322  Drivers    Other      jeffpc@optonline.net
double logical operator drivers/char/sx.c

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

493  Drivers    USB        mdharm-usb@one-eyed-alien.net
Support for Sony DSC-P72 not available

719  Process    Schedule   rml@tech9.net
[perf][kernbench] lower performance with HT enabled on low loads

807  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
gprs pcmcia card not works in linux

820  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA emu10k doesn't load in 2.5.7[12]

858  Timers     Interval   bugme-janitors@lists.osdl.org
itimer resolution and rounding vs posix

992  Drivers    USB        greg@kroah.com
mount options of usbfs (like devgid and devmode) are ignored

1080  Drivers    Sound      francesco@unipg.it
alsa driver snd-powermac doesn't work with tumbler on iBook2

1209  Drivers    SCSI       willy@debian.org
sym53c8xx_2 oopses

1221  Drivers    USB        greg@kroah.com
USB ACM modem driver doesn't work any more since kernel 2.6.0-test3

1241  Drivers    Input De   vojtech@suse.cz
wrong condition in drivers/input/serio/Kconfig

1246  Drivers    USB        mdharm-usb@one-eyed-alien.net
Ooops while copying from usb smartmedia reader

1258  Drivers    IEEE1394   bcollins@debian.org
sbp2 reports slab corruption of hpsb_packet in 2.6.0-test5-mm3

1261  Drivers    USB        dbrownell@users.sourceforge.net
ehci_hcd in sysfs

1286  Drivers    USB        greg@kroah.com
System stall on probing uhci-hcd

1310  Drivers    USB        dbrownell@users.sourceforge.net
Usb storage mounting was broken somewhere between 2.6.0-test5-bk10 and 
2.6.0-tes

1377  Other      Configur   zippel@linux-m68k.org
make O=... xconfig uses wrong -I paths

1449  Drivers    IEEE1394   bcollins@debian.org
sleeping function called from invalid context


