Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311418AbSCWXjm>; Sat, 23 Mar 2002 18:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311419AbSCWXjb>; Sat, 23 Mar 2002 18:39:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39943 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311418AbSCWXjX>; Sat, 23 Mar 2002 18:39:23 -0500
Date: Sun, 24 Mar 2002 00:39:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Blais <blais@iro.umontreal.ca>
Cc: Martin Blais <blais@discreet.com>, linux-kernel@vger.kernel.org
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Message-ID: <20020323233906.GA24887@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there> <200203221829.NAA22671161@cuba.discreet.qc.ca> <20020322214413.GG16382@atrey.karlin.mff.cuni.cz> <20020323204804.ZOIW905.tomts8-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > that seems more like a patch problem/improvement request. i wouldn't do
> > > the patch myself... however, with the rejected hunks problem, i wonder if
> > > it is at all possible to avoid implementing patch functionality in the
> > > diffing tool itself.
> >
> > Question is how to do it in patch. Even one *long line* can be too
> > much, and then your horizontal highlight would come very handy.
> 
> actually, thinking more about it, having to use patch is not really a problem 
> for the BK use case discussed on this list, as BK most likely can
> provide the 

I'm not using bitkeeper. RMS told me not to use it, Larry told me not
to use it, Davem told me not to use it... So I'm not using it ;-).

So it still would be nice to have some scripts for automatic script
applying.

And yes, I usually do have common ancestor (namely clean version of
kernel I'm trying to patch.)

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
