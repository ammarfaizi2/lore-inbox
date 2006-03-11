Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWCKMGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWCKMGW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWCKMGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:06:22 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:42147 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1750790AbWCKMGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:06:22 -0500
Date: Sat, 11 Mar 2006 13:07:09 +0100
From: DervishD <lkml@dervishd.net>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060311120709.GB98@DervishD>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20060311091623.GB4087@DervishD> <MDEHLPKNGKAHNMBLJOLKGEHBKKAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEHBKKAB.davids@webmaster.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

 * David Schwartz <davids@webmaster.com> dixit:
> >     I don't want my work used by a corporation without giving any
> > modification under the same conditions under I published my work.
> > Binary driver can and will do harm if allowed.
> 
> 	If you want to restrict *use* you need an EULA, shrink wrap agreement,
> click-through or signed contract. If you give away copies of your work with
> no conditions on the *receipt* of the work, you lose the right to control
> how the work is used. Otherwise, someone could drop a million copies of
> their poem from an airplane and then sue everyone who read it.

    Sorry, I meant "make a derivative work and distribute it" when I
wrote "used by a corporation without giving any modification...".
My english is very poor sometimes O:)

    I was referring to the fact that if I use GPL is because I don't
want anyone using my work to produce new work and distribute it
without distributing the modification, too. In the kernel case, a
binary driver uses work made by others without giving anything back
(and not, I don't consider the driver itself enough "giving back"),
at least that's how I see it.

    If binary drivers are allowed, soon we will have only drivers for
a couple of distros (I don't use a distro, so I'm lost) and they will
be unmaintained as soon as new hardware is released. I have had that
problem in Windows with hardware that is only three years old,
hardware that I can use in Linux without problem (my Linux box is 5
years old on the average, but my graphics card was manufactured in
1998 IIRC). In MS-DOS, binary drivers were an issue because they were
abandoned as soon as Windows-95 was released, but the worst thing is
that a good bunch of GOOD hardware will work ONLY with the latest
release of WinXP. I don't want that to happen in Linux. And if I have
the sources, I have a chance of fixing bugs or whatever.

    I know copyright won't help in that issue, but licensing can, and
I think that the kernel is doing the right thing.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
