Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSKCUHT>; Sun, 3 Nov 2002 15:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSKCUHQ>; Sun, 3 Nov 2002 15:07:16 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:64462 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262452AbSKCUGl>;
	Sun, 3 Nov 2002 15:06:41 -0500
Date: Sun, 3 Nov 2002 21:13:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103211308.B8636@ucw.cz>
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz> <20021103193734.GC2516@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021103193734.GC2516@pasky.ji.cz>; from pasky@ucw.cz on Sun, Nov 03, 2002 at 08:37:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 08:37:34PM +0100, Petr Baudis wrote:
> Dear diary, on Sun, Nov 03, 2002 at 08:07:05PM CET, I got a letter,
> where Vojtech Pavlik <vojtech@suse.cz> told me, that...
> > On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:
> > > Jos Hulzink wrote:
> > > 
> > > >It took me about an hour to find out why my keyboard didn't work in 2.5.45. 
> > > >Well... after all it seemed that I need to enable 4 ! options inside the 
> > > >input configuration, just to get my default, nothing special PS/2 keyboard up 
> > > >and running. Oh, and I didn't even have my not so fancy boring default PS/2 
> > > >mouse configured then. Guys, being able to configure everything is nice, but 
> > > >with the 2.5 kernel, things are definitely getting out of control IMHO.
> > > >  
> > > >
> > > 
> > > This is potentially becoming a FAQ...  I ran into this too, as did 
> > > several people in the office.  People who compile custom kernels seem to 
> > > run into this when they first jump into 2.5.x.  AT Keyboard support is 
> > > definitely buried :/
> > > 
> > > Unfortunately I don't have any concrete suggestions for Vojtech (input 
> > > subsystem maintainer), just a request that it becomes easier and more 
> > > obvious how to configure the keyboard and mouse that is found on > 90% 
> > > of all Linux users computers [IMO]...
> > 
> > Too bad you don't have any suggestions. I completely agree this should
> > be simplified, while I wouldn't be happy to lose the possibility of not
> > compiling AT keyboard support in.
> 
> Well, why can't it be enabled by default? Other options are as well, and it's
> IMHO sane to enable keyboard and mice support by default. It should clear up
> the initial confusion as well.

All the needed options ARE enabled by default. (check arch/i386/defconfig)

> I think that those are absolute minimum and if anyone will want to have any of
> these explicitly off, he's more likely to know where to turn it off, rather
> than vice versa.

-- 
Vojtech Pavlik
SuSE Labs
