Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKEXDl>; Sun, 5 Nov 2000 18:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbQKEXDc>; Sun, 5 Nov 2000 18:03:32 -0500
Received: from DKBH-T-004-p-250-136.tmns.net.au ([203.54.250.136]:25861 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S129121AbQKEXDN>;
	Sun, 5 Nov 2000 18:03:13 -0500
Message-ID: <3A05E5B1.F3E1CA09@eyal.emu.id.au>
Date: Mon, 06 Nov 2000 09:56:49 +1100
From: Eyal Lebedinsky <livid@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pppd and 2.4.0pre10
In-Reply-To: <Pine.LNX.4.21.0011041757570.32560-100000@tahallah.clara.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell wrote:
> 
> tahallah[alex]:/home/alex > ppp-on
> 
> tahallah[alex]:/home/alex > /usr/sbin/pppd: This system lacks kernel
> support for PPP.  This could be because the PPP kernel module could not be
> loaded, or because PPP was not included in the kernel configuration.  If
> PPP was included as a module, try `/sbin/modprobe -v ppp'.  If that fails,

I have something different with ppp on 2.4.0-test10. I very often get
the ppp link up, I can ping the ISP end of the connection, but nothing
else. All the pppd messages look just fine coming up.

I called the ISP tech support and they say my connection is not showing
as active on their end. Then again Telstra (the Australian telco people)
have sold their soul to the devil and when you say you use Linux (or
anything non MS windows) they go very unhelpful reciting their mantra
"we only support windows" to everything I say.

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
