Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSGIU0o>; Tue, 9 Jul 2002 16:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSGIU0o>; Tue, 9 Jul 2002 16:26:44 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:46814 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S317405AbSGIU0m>;
	Tue, 9 Jul 2002 16:26:42 -0400
Subject: Re: [OT] freezing afer switching from graphical to console
From: Bongani <bonganilinux@mweb.co.za>
To: J Sloan <jjs@lexus.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2B1D0A.1050509@lexus.com>
References: <E17Rrf9-0003wV-00@laibach.mweb.co.za> 
	<3D2B1D0A.1050509@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 09 Jul 2002 22:32:19 +0200
Message-Id: <1026246742.2479.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-09 at 19:27, J Sloan wrote:
> bonganilinux@mweb.co.za wrote:
> 
> >>Hi,
> >>
> >>since 2.4.17 I have got a problem: trying to switch from graphical
> >>screen to console or to stop my X-session my box freezes. The screen
> >>gets black and nothing more happens. Pressing any keys or trying to
> >>    
> >>
> >
> >This only happens to me if I load the NVidia drivers if you are using
> >them that could be you
> >problem.
> >  
> >
> How bizzarre - I've never seen that
> with the nvidia drivers - I gave away
> an ATI card to a windoze user since
> the ATI DRI would hard lock the box.
> 
> (I know, help is on the way, but I had
> an immediate need!)
> 
> Since switching to a GeForce 2, there
> have been no problems whatsoever.
> 
> When you say "that only happens" if
> you "load the nvidia drivers", do you
> mean to say that you only see that
> freeze if you run X windows? Or, that
> you see it only if you enable DRI?
> 
> Lots of things beside nvidia to blame,
> if we are on a witchhunt....
> 
> Joe

I am also using GeForce 2 currently I am using the nvidia drivers
that comes with X window. NOTE: they do _not_ support DRI. The only
drivers that support DRI are those that I supplied by NVidia (as far as
I know)

The freeze when switching from graphic mode to console has been around
for a while now look at:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.2/0237.html
and yes not everyone who complained had the nvidia drivers loaded.

Yes the could be other things that causes the hangs, but _I_ only
experience those hangs when _I_ use the nvidia drivers.I'm not on a
witch hunt, but when I can't reproduce the problem without the nvidia
drivers. I think it is logical to start suspecting that the problem is
caused by those drivers.

Bongani
 


