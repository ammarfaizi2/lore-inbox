Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSCYSXi>; Mon, 25 Mar 2002 13:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312487AbSCYSX3>; Mon, 25 Mar 2002 13:23:29 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:25736 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312486AbSCYSXU> convert rfc822-to-8bit; Mon, 25 Mar 2002 13:23:20 -0500
Message-Id: <200203251821.g2PIL7oA005522@codeman.linux-systeme.org>
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Reply-To: mcp@linux-systeme.de
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Kernel 2.4.18-WOLK3.1
Date: Mon, 25 Mar 2002 19:21:07 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-PRIORITY: 2 (High)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel - patched - WOLK3.1 - Base: Linux kernel 2.4.18

by Marc-Christian Petersen <mcp@linux-systeme.de>


This is my second public release. WOLK 3.1 is now available as full kernel
AND as a patchset. There were some requests to do it, so here it is :)
WOLK 3.1 contains several bugfixes found in WOLK 3.0 (formerly known as
mcp3-WOLK), reported by users of wolk and found by myself.
Project name change cause WOLK looks nicer than of mcp-WOLK.

Thanks to darix <darix@irssi.de> for the project name WOLK :-)


What is this? Why another patchset/patched kernel?

Using Linux since years, very tired of there are not really good
patchsets available. Saw FOLK Patch/Kernel which is still very very buggy.
Inspired by the jp-Patchsets from Joerg Prante <joerg@infolinux.de>.

The WOLK's are development kernels/patchsets for testing purpose only.
!! If you want to use it in production, use it at your own risk !!
Their purpose is to provide a service for developers and end-users who
can't be up to date with the latest official stable kernels/patches but
want to test many features out there linux can use. Maybe, (hopefully)
some of them will be included into the mainstream kernel 2.4 soon.

There will always be a new WOLK major release if there is a new final
kernel released. Minor releases only if someone/me found critical bugs.

You are missing a patch? Patches will be added by request.
You think one or more of the patches are fully useless? Tell me why.
You have minor, major or heavy mega problems, let me know. I will try to fix.
You think this is great? Let me know too :-)

You want YOUR patch to be included in WOLK? Let me know :)

There is also a mailinglist available you can join at:
https://sourceforge.net/mail/?group_id=49048


Overview:
---------
For an overview go to http://sf.net/projects/wolk
The WOLK 3.1 kernel/patchset contains over 90 Patches

Credits go to all the people who created the patches, working hard on
improving the quality.



Changes in WOLK 3.1
-------------------
o   removed:    load-kill patch (causes panics)
o   update:     Tekram DC395 v1.38
o   update:     Event Logging v1.30
o   update:     Compressed Cache 0.22 final
o   update:     Win4Lin  mki-adapter Patch update to 1.07
o   add:        FTP fs
o   add:        ISDN LZS Compression
o   add:        TUX
o   add:        UML
o   add:        Linux Trace Toolkit
o   add:        Broadcom Tigon3 support
o   small other patches (IDE, RAID ...)
o   Minor fixes found in WOLK 3.0
o   moved the tools to an extra package



Todo for the next releases:
---------------------------
o  Mosix/OpenMosix (why the hell they are so slow to
   release new patches. Hurry up !!
o  maybe OpenAFS
o  maybe OpenGFS
o  ALSA
o  grsecurity/preempt + Win4Lin coexistence
   (Brad/Michael, can you help me with it?)
o  If 2.4.19 is final: Reverse Mapping VM



--------------------------------------------------------------------------
Feel free to send me feedback. Please CC, I am not subscribed to the lkml.
--------------------------------------------------------------------------

The next major WOLK (WOLK 4) will be available some days after the 2.4.19
final kernel release.


Enjoy!

Marc-Christian Petersen <mcp@linux-systeme.de>
Unix/Linux Administrator
Essen, Germany

