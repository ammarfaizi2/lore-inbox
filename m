Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279454AbRKOBAn>; Wed, 14 Nov 2001 20:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279548AbRKOBAd>; Wed, 14 Nov 2001 20:00:33 -0500
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:25761 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S279454AbRKOBAZ>;
	Wed, 14 Nov 2001 20:00:25 -0500
Message-ID: <3BF31459.BB4BE456@randomlogic.com>
Date: Wed, 14 Nov 2001 17:03:21 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <20011113.183256.15406047.davem@redhat.com>
		<Pine.LNX.4.30.0111131910440.9658-100000@anime.net> <20011113.191607.00304518.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Dan Hollis <goemon@anime.net>
>    Date: Tue, 13 Nov 2001 19:11:56 -0800 (PST)
> 
>    BTW this bug apparently doesnt affect AMD760MP as I am able to use
>    geforce2 with quake and unreal tournament for hours straight without any
>    problems.
> 
> What is your quake3 com_maxfps set to?  By default it is 85, and
> that can hide the bug.  Set it to 130 or something like that.
> 
> Just bring down the quake3 console (with ') and type
> 
> /com_maxfps 130
> 
> Try that for a while.
> 
> I'm rather sure the AMD761 problems are motherboard vendor
> independant, because I have 2 systems so far, using totally different
> AMD761 based motherboards, which both hang pretty reliably with AGP.
> 

My dual Tyan runs Q3A, UT, and Tribes 2 at over 100fps at times with no problems UNLESS I enable DMA for the IDE drive. Q3a will go above 130fps (map and game
dependent), UT will go even higher, and Tribes 2 will hit right around 140fps if I'm in a room (any outdoor areas slow WAY down).

I am running 2.4.9ac10 with a few minor tweaks, agpgart slightly tweaked compiled in, and a tweaked Detonator 3 nVidia driver. I plan to upgrade all these soon
and see what happens.

My A7V133 however is crap when it comes to playing games. It's been demoted to straight server duty. :)

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
