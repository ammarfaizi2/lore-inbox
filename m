Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271000AbRHOCXD>; Tue, 14 Aug 2001 22:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271001AbRHOCWy>; Tue, 14 Aug 2001 22:22:54 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:9769 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S271000AbRHOCWn>; Tue, 14 Aug 2001 22:22:43 -0400
Message-Id: <4.3.2.7.2.20010814191750.00ba6430@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 14 Aug 2001 19:22:48 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: Mouse weirdness
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I give up.  HELP!

I'm running 2.2.5 on some system, 2.2.19 on others.  When I start X the 
mouse (one of the later PS/2-USB hybrids) is fine, but at some point the 
mouse decides that it's in a USB port and that's all she wrote.  Even 
text-mode mouse support is broken, causing all sorts of things including 
what appears to be keystrokes.  I can't get the mouse (Logitech) to reset 
itself to PS/2 mode, and the ONLY solution is to reboot all the systems.

I don't think this is Linux-specific, as I have the problem with the 
WinBlows box too.

Motherboards are Asus P5A-B.

Is there any way to tickle the Linux system to reset the mouse logic so 
that the mouse would work again?  (Don't say "unload the module" because 
right now the PS/2 mouse support is compiled in, and customizing the kernel 
generates other, unrelated problems with compilation.)

Satch

