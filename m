Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSLDCmf>; Tue, 3 Dec 2002 21:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266846AbSLDCme>; Tue, 3 Dec 2002 21:42:34 -0500
Received: from pcp103897pcs.glstrt01.nj.comcast.net ([68.45.109.175]:1664 "EHLO
	sorrow.ashke.com") by vger.kernel.org with ESMTP id <S266842AbSLDCme>;
	Tue, 3 Dec 2002 21:42:34 -0500
Date: Tue, 3 Dec 2002 21:50:04 -0500 (EST)
From: Adam K Kirchhoff <adamk@voicenet.com>
X-X-Sender: adamk@sorrow.ashke.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20 - hangs when rebooting...
Message-ID: <Pine.LNX.4.44.0212032146020.2089-100000@sorrow.ashke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

	I've encountered a new problem since upgrading from 2.4.19 to 
2.4.20.  Basically, when I go to reboot my machine, it hangs imeddiate 
after it says "Restarting system".  Then nothing.  I have to hit the reset 
button.  Thankfully, though, everything has already been unmounted.  I 
never had this problem with 2.4.19, nor do I have it now if I reboot into 
2.4.19.  After it says "Restarting system", the screen blanks and the 
computer reboots :-)

	My kernel configuration between the two is the exact same.  The
only reason why I upgraded was for better support of my ICH4 IDE
controller on a fairly new motherboard.  This is an Intel i845 with a 2
Gig P4 processor, 512 Megs RAM.  Happens with both apm disabled and 
enabled.  

	Any ideas? :-) Thanks.

Adam


