Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKDSAf>; Sat, 4 Nov 2000 13:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKDSAZ>; Sat, 4 Nov 2000 13:00:25 -0500
Received: from tahallah.claranet.co.uk ([212.126.138.206]:11649 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S129044AbQKDSAN>; Sat, 4 Nov 2000 13:00:13 -0500
Date: Sat, 4 Nov 2000 17:59:21 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
Reply-To: alex.buell@tahallah.clara.co.uk
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: pppd and 2.4.0pre10
Message-ID: <Pine.LNX.4.21.0011041757570.32560-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tahallah[alex]:/home/alex > ppp-on

tahallah[alex]:/home/alex > /usr/sbin/pppd: This system lacks kernel
support for PPP.  This could be because the PPP kernel module could not be
loaded, or because PPP was not included in the kernel configuration.  If
PPP was included as a module, try `/sbin/modprobe -v ppp'.  If that fails,
check t

I'm getting this problem each time I start pppd whenever I dial up if the
ppp modules have been unloaded from memory. The odd thing is that I can
repeat 'ppp-on' and it will work fine! Notice how the rest of the text in
the above output from pppd is cut off.

Cheers, 
Alex
-- 
Quakers can play Quake as long as they don't fire any weapons 
and instead just use "chat" to try to reason all the other 
players out of their mindlessly violent ways... 

http://www.tahallah.clara.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
