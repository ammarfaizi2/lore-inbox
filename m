Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319446AbSIGHEx>; Sat, 7 Sep 2002 03:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319447AbSIGHEx>; Sat, 7 Sep 2002 03:04:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8713 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319446AbSIGHEw>; Sat, 7 Sep 2002 03:04:52 -0400
Date: Sat, 7 Sep 2002 00:08:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: DevilKin <devilkin-lkml@blindguardian.org>
cc: jbradford@dial.pipex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide drive dying?
In-Reply-To: <200209061755.06344.devilkin-lkml@blindguardian.org>
Message-ID: <Pine.LNX.4.10.10209070007540.11256-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Send me the results offline

On Fri, 6 Sep 2002, DevilKin wrote:

> On Friday 06 September 2002 17:36, jbradford@dial.pipex.com wrote:
> > > I've looked up these errors on the net, and as far as i can tell it means
> > > that the drive has some bad sectors at the given addresses and that it
> > > will probably die on me sooner or later.
> > >
> > > Can someone either confirm this to me or tell me what to do to fix it?
> > >
> > > The drive involved is an IBM-DTLA-307060, which has served me without
> > > problems now for about 2 years.
> >
> > Have a look at:
> >
> > http://csl.cse.ucsc.edu/smart.shtml
> >
> > there you will find software for interrogating and monitoring the
> > S.M.A.R.T. data available from your drive.  It's a little late to start
> > monitoring it, if the drive is already dying, but if, for example, it shows
> > a lot of re-allocated sectors, or spin retries, you'll know something is
> > wrong.
> >
> 
> OK, I downloaded that and installed it, but well, frankly, it shows me very 
> little useful stuff.
> 
> Or i'm just not good at interpreting this.
> 
> DK
> 
> -- 
> "I gained nothing at all from Supreme Enlightenment, and for that very
> reason it is called Supreme Enlightenment."
> 		-- Gotama Buddha
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

