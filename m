Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265803AbSKFQjO>; Wed, 6 Nov 2002 11:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265805AbSKFQjO>; Wed, 6 Nov 2002 11:39:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47882 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265803AbSKFQjN>; Wed, 6 Nov 2002 11:39:13 -0500
Date: Wed, 6 Nov 2002 11:45:12 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Module loader against 2.5.46: 8/9 
In-Reply-To: <20021105035229.B20202C0E8@lists.samba.org>
Message-ID: <Pine.LNX.3.96.1021106113408.24531B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Rusty Russell wrote:

> In message <20021105001905.D1407@almesberger.net> you write:
> > [ Cc: trimmed ]
> > 
> > Rusty Russell wrote:
> > > +config OBSOLETE_MODPARM
> > > +	bool
> > > +	default y
> > > +	help
> > > +	  Without this option you will not be able to use module parameters on
> > > +	  modules which have not been converted to the new module parameter
> > > +	  system yet.  If unsure, say Y.
> > 
> > Triple negation, cool :-) How about something like
> > 
> > 	You need this option to use module parameters on
> > 	modules which have not been converted to the new module parameter
> > 	system yet.  If unsure, say Y.
> > 
> 
> No.  I don't think that my original version wasn't clear, nor do I
> have time to negate every suggestion, no matter how well meaning or
> not, even if I had no better things to do, which does not seem likely,
> does it not?

Please don't take this personally, but you just used another double
negative in your response. Now you may think that way, and talk that way,
but a lot of people who use Linux are not native speakers of English, and
from experience I suggest that the complex gramatical constructs in all
the help stuff should be avoided. Eschew obfuscation.
 
> Point taken (although note that this option is never prompted for).

Then why have help at all? In fact why have the whole option if it can't
be used? I assume you meant something else entirely, other than "can't be
used."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

