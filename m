Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271805AbRICUkN>; Mon, 3 Sep 2001 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271806AbRICUkE>; Mon, 3 Sep 2001 16:40:04 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:53252
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S271805AbRICUjq>; Mon, 3 Sep 2001 16:39:46 -0400
Date: Mon, 3 Sep 2001 16:49:53 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Simon Hay <simon@haywired.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
Message-ID: <20010903164953.A3243@animx.eu.org>
In-Reply-To: <20010903214829.B17488@unthought.net> <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain>; from Simon Hay on Mon, Sep 03, 2001 at 09:11:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > XFree86 has pretty good support for multiple heads.
> >
> > If you tie an xterm to the root window, I guess you would get something
> > pretty close to what you're looking for.  Or, configure some window manager
> > properly to do exactly what you want.
> >
> 
> I had considered doing that - I believe that some of the framebuffer
> code supports multiple heads as well(?) - but in this particular case it
> wasn't appropriate - the whole point was to demonstrate what could be
> achieved using only a command line ;-)  Also, though, on dedicated servers
> etc. I'd rather not be running X if I didn't have to.  Would this be a
> particularly difficult thing to implement as a kernel patch?  I'd like to
> try to get involved in kernel development at some point and am looking for
> something to ease myself in slowly - preferably something useful but
> unimportant ;-)  Are there any show stoppers involved here - or does
> anyone have any other ideas?

I thought of doing something like this but using a matrox g400 or g450 dual
head card.  primary would be for X, secondary would be a console.  Not sure
if that's more difficult or not.  Something I'd like to have, however.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
