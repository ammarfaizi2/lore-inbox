Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSG1Ifz>; Sun, 28 Jul 2002 04:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSG1Ifz>; Sun, 28 Jul 2002 04:35:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:28592 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313628AbSG1Ify>;
	Sun, 28 Jul 2002 04:35:54 -0400
Date: Sun, 28 Jul 2002 10:39:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [cset] Add the EVIOCSABS ioctl for X people.
Message-ID: <20020728103906.A12465@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <200207281732.53842.bhards@bigpond.net.au> <20020728100812.A12268@ucw.cz> <200207281829.02627.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207281829.02627.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sun, Jul 28, 2002 at 06:29:02PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 06:29:02PM +1000, Brad Hards wrote:
> On Sun, 28 Jul 2002 18:08, Vojtech Pavlik wrote:
> > On Sun, Jul 28, 2002 at 05:32:53PM +1000, Brad Hards wrote:

> > > "current" is a bad idea. I used curr_value.
> > How about just "value" then?
> If you want shorter, "curr" would be more understandable.
> As you pointed out, all the structure elements are values.
> Someone else might have a better name than "curr" though.

I just want it simple.

> > I'm stil fighting with BK to use something else than my e-mail address
> > in the changesets. So far I've always put the author of the patch into
> > the BK comment at least, but still haven't found how to change the cset
> > author.
> It depends on an environment variable (see BK hacking howto in the
> 2.5 tree).

Cool, I've read this in the past, but didn't remember this one.

> Like you, I am still strugling with BK. Hence the conventional
> patches.
> 
> > If you find out, please tell me. Or anybody else.
> >
> > Thanks.
> master.kernel.org:/home/torvalds/BK/tools apparently has some
> scripts - I don't have access.

I don't either. 

-- 
Vojtech Pavlik
SuSE Labs
