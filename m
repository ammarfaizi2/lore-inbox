Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317960AbSG0HAA>; Sat, 27 Jul 2002 03:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSG0HAA>; Sat, 27 Jul 2002 03:00:00 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61402 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317960AbSG0HAA>;
	Sat, 27 Jul 2002 03:00:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface 
In-reply-to: Your message of "Fri, 26 Jul 2002 13:15:53 EST."
             <Pine.LNX.4.44.0207261313280.384-100000@chaos.physics.uiowa.edu> 
Date: Sat, 27 Jul 2002 17:00:32 +1000
Message-Id: <20020727070410.B44A0418B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207261313280.384-100000@chaos.physics.uiowa.edu> you
 write:
> On Fri, 26 Jul 2002, Rusty Russell wrote:
> 
> > > Not yet. The problem is the module name, e.g. ext2 is called
> > > fs_ext2_super, it will need some kbuild changes to get the right module
> > > name.
> > 
> > I need that too: the mythical "KBUILD_MODNAME".  Both Keith and Kai
> > promised it to me...
> 
> I told you that I have the code, and that I can provide it to you as soon
> as you need it. You did never ask for it, though. Do you need it now?

Sorry for the misunderstanding, I expected it to appear in the build
system one day magically 8)

You can just send me the patch though, and I'll throw it on my page
and make the module replacement patch Depend: on it.  I'll also give
it some good testing.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
