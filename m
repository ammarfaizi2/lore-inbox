Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279717AbRKOBsl>; Wed, 14 Nov 2001 20:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279998AbRKOBsa>; Wed, 14 Nov 2001 20:48:30 -0500
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:30881 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S279717AbRKOBsW>;
	Wed, 14 Nov 2001 20:48:22 -0500
Message-ID: <3BF31F92.27CF811@randomlogic.com>
Date: Wed, 14 Nov 2001 17:51:14 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart Young <sgy@amc.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <3BF31459.BB4BE456@randomlogic.com> <5.1.0.14.0.20011115122046.02028de0@mail.amc.localnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Young wrote:
> 
> At 05:15 PM 14/11/01 -0800, Dan Hollis wrote:
> >On Wed, 14 Nov 2001, Paul G. Allen wrote:
> > > I am running 2.4.9ac10 with a few minor tweaks, agpgart slightly tweaked
> > > compiled in, and a tweaked Detonator 3 nVidia driver
> >                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >???
> 

I made a couple small changes so that it would recognize the MP chipset and not drop to a generic operational mode. The generic mode did not work properly and
would cause occasional system hangs. Fast writes still won't work, but I think a BIOS upgrade might fix that.

> Damn binary thing.
> 
> It's the same core code as the Windows Detonator 3 driver. Hence the mention.
> 
> The next one will be based on the Detonator 4 core code, so things like
> OpenGL 1.3 (which is supposedly available with the Detonator 4 drivers
> under Windows) will be available.
> 
> Paul, you may want to see my post earlier re 2.4.14 vanilla and my
> experiences so far, which have all been good.
> 

I just saw it. I am a registered nVidia developer, but have been too busy with other things (mainly working on the V12 game engine) to look into updating my
actual system software and ping on nVidia about their Linux driver. I asked them once a while back, and they said "A new driver will be released soon, so wait
for that."

I'm getting ready to do it though, since I need to wait for another developer to fix some code (in the game engine) before I can continue.

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
