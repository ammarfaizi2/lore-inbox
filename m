Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270461AbTGSEH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 00:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTGSEH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 00:07:58 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39587 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270461AbTGSEH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 00:07:57 -0400
Message-ID: <3F18C90B.305@innocent.com>
Date: Sat, 19 Jul 2003 00:28:59 -0400
From: "Constantine 'Gus' Fantanas" <fantanas@innocent.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: menuconfig crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To Whom it May Concern:

I experienced a menuconfig crash and I am following the notication 
instructions of the error message (pasted below).  At the time of the 
crash, I was in the sound configuration section and was entering the 
ALSA configuration subsection. The kernel I was trying to configure was 
a Mandrake 2.4.21 kernel: linux-2.4.21-0.18mdk.

Here is the error message:

-------------BEGINNING OF PASTED MATERIAL------------------------------

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu73: command not found

 Please report this to the maintainer <mec@shout.net>.  You may also
 send a problem report to <linux-kernel@vger.kernel.org>.

 Please indicate the kernel version you are trying to configure and
 which menu you were trying to enter when this error occurred.

 make: *** [menuconfig] Error 1

------------END OF PASTED MATERIAL----------------------------------------

The system I was trying to configure this kernel on was an old 200 MHz 
Pentium MMX with 64 MB of RAM (so old that it had PCI and USB, but no 
AGP; the video card was plugged into a PCI slot).

Regards,

Gus Fantanas

