Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUIECmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUIECmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUIECmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:42:37 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8607 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266116AbUIECmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:42:33 -0400
Message-Id: <200409050203.i8523X6W031952@localhost.localdomain>
To: Lee Revell <rlrevell@joe-job.com>
cc: Tim Fairchild <tim@bcs4me.com>, Christoph Hellwig <hch@infradead.org>,
       Sid Boyce <sboyce@blueyonder.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NVIDIA Driver 1.0-6111 fix 
In-Reply-To: Message from Lee Revell <rlrevell@joe-job.com> 
   of "Sat, 04 Sep 2004 17:22:29 -0400." <1094332949.6575.360.camel@krustophenia.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sat, 04 Sep 2004 22:03:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> said:
> Tim Fairchild <tim@bcs4me.com> said:

[...]

> > Users don't really care about open and closed source. They just want 
> > to play quake 3 (etc).

> I have never understood why these people don't just run Windows.

Some run Linux because it _works_, and also want to play.

>                                                                   I have
> also never understood why people make so much noise about having to use
> a closed source driver to play A CLOSED SOURCE GAME!  What's next, a
> petition to open the UT2004 source?  Sheesh...

8-D

> > I've never had an oops that was specifically caused by the nvidia
> > module, tho I suppose it does happen.

> And I have never seen one either.

How do you know?

>                                    I am just using the OOPS'es as an
> indication of how many Linux users use this driver.

How do you know the OOPSes aren't caused (indirectly) by nVidia? Sure, the
incidence seems to have gone down, and perhaps lusers have learnt not to
post OOPSes for tainted kernels...

>                                                      It's WAY more than
> I expected.

Now you confuse me... you see _many_ OOPSes with nVidia, but know for
_sure_ nVidia has nothing to do with it?

>              The open source nv.o module works fine for me, I don't see
> how the 2D would need to be faster, or how you would even tell the
> difference.

Try using a 1280x800 screen (wide notebook screen, as on Toshiba M30), nv
says that is incorrect and gives you a (very distorted) 1024x768. Up to
here, the binary module is the only way out for me (and I don't care for 3D
or high-performance 2D).

> I suspect many of these users are ricers who tweak CFLAGS and compare
> benchmark scores all day, and cannot bear to use the open source driver
> if it will make their machine 1% slower.  I was surprised to find that
> apparently there are open source ATI 3D drivers after all but some
> people are petitioning ATI anyway because these 'aren't as good' as the
> binary ones.  So fix it already, this is open source, and if you can't,
> then please learn to write code or STFU.

Right.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
