Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUANOck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUANOck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:32:40 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51966 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261681AbUANOc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:32:27 -0500
Message-ID: <4005526D.3060604@us.ibm.com>
Date: Wed, 14 Jan 2004 09:30:05 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs sitting in the RESOLVED state for more than 60 days
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in RESOLVED state for more than 60 days,
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

1349  Power Ma   ACPI       len.brown@intel.com
processor.c using byte IO even if DSDT prescribes otherwise

1377  Other      Configur   zippel@linux-m68k.org
make O=... xconfig uses wrong -I paths

1449  Drivers    IEEE1394   bcollins@debian.org
sleeping function called from invalid context

