Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbRF2HxP>; Fri, 29 Jun 2001 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRF2HxF>; Fri, 29 Jun 2001 03:53:05 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:58374 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265747AbRF2Hw5>;
	Fri, 29 Jun 2001 03:52:57 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15164.12795.968325.311643@cargo.ozlabs.ibm.com>
Date: Fri, 29 Jun 2001 17:44:59 +1000 (EST)
To: Cort Dougan <cort@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <20010629002906.E4348@ftsoj.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.33.0106281028170.10308-100000@localhost.localdomain>
	<Pine.LNX.4.33.0106281035250.15199-100000@penguin.transmeta.com>
	<15164.6716.301922.3947@cargo.ozlabs.ibm.com>
	<20010629002906.E4348@ftsoj.fsmlabs.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cort Dougan writes:

> Can we then expect to see all mention of authors in drivers disappear from
> the boot? 

I think we'll either see a lot more or a lot less.  In my example I
would have had no particular problem with a message saying "PPP driver
copyright Al Longyear and Michael Callahan" or whatever.  What annoyed
me was the noisy copyright message about something that was only 20 or
30 lines of code, and not especially clever code at that.

If copyright messages on boot are the way we get credit for the work
we've done, then I have a few to add myself. :)

My personal preference is for a quieter boot, with basically no
copyright messages.  It's Linus' call though.

> Same with url's, version #'s and the like?

See all the previous messages in this thread. :)

>  The built by
> user@host message is a good bit of "drumming ones own drum" while
> contributing very little (running 'make' vs. writing the system).

Isn't that more a "who to blame" than credit?

Paul.
