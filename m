Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289757AbSAKG5f>; Fri, 11 Jan 2002 01:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289830AbSAKG5Z>; Fri, 11 Jan 2002 01:57:25 -0500
Received: from ns2.generalbroadband.com ([64.32.62.5]:58116 "EHLO
	mx1.relaypoint.net") by vger.kernel.org with ESMTP
	id <S289757AbSAKG5N>; Fri, 11 Jan 2002 01:57:13 -0500
Message-ID: <3C3E8D2A.66C96E37@laposte.net>
Date: Thu, 10 Jan 2002 22:58:51 -0800
From: Mike <m.mohr@laposte.net>
X-Mailer: Mozilla 4.51 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.[0&1]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening everyone.

I'm new to this list.  After using Linux off and on for about 1 year, I
have learned just enough to get around and do very basic system
maintenance.  I am at the point where I need to recompile my kernel.  I
have done so successfully with the source-code included in my dist
(Slackware 8 currently), but am having problems with the most current
kernels.

Kernel sources decompressed without error and compiled just as expected,
no errors.  Total bzImage size was about 920kb.  After using LILO to
install kernel 2.5.0 and rebooting, my computer shows the Loading
Linux............ text, then very briefly shows OK, Uncompressing
Linux..., but immediately reboots the system before it can initialize.

Kernel 2.5.1 is not much better; it freezes the system immediately after
showing the OK, decompressing the kernel message.  I would like to
attempt upgrading the kernel to this latest version, but it won't even
get far enough in the boot process to load my root filesystem.  What can
I do, or what have I done wrong?

I also installed the kernel onto a bootdisk using both LILO and dd with
the same exact results.  Please send me any suggestions!

Thanks,
Michael Mohr

