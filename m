Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSBFIEP>; Wed, 6 Feb 2002 03:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290232AbSBFIEF>; Wed, 6 Feb 2002 03:04:05 -0500
Received: from bitmover.com ([192.132.92.2]:47533 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290223AbSBFIDx>;
	Wed, 6 Feb 2002 03:03:53 -0500
Date: Wed, 6 Feb 2002 00:03:43 -0800
From: Larry McVoy <lm@bitmover.com>
To: Reid Hekman <reid.hekman@ndsu.nodak.edu>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206000343.I14622@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Reid Hekman <reid.hekman@ndsu.nodak.edu>,
	Andreas Dilger <adilger@turbolabs.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0202051928330.2375-100000@cesium.transmeta.com> <20020205235000.J2928@lynx.turbolabs.com> <1012981874.6918.10.camel@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1012981874.6918.10.camel@zeus>; from reid.hekman@ndsu.nodak.edu on Wed, Feb 06, 2002 at 01:50:34AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I second that. Maybe however we can have it both ways -- I have no
> experience with bk, but can't this same info be made available elsewhere
> like a public web interface or some such thing?

I've put up read-only clones on 

	http://linux.bkbits.net

you can go there and get the changelogs in web form.  I just figured out
what a bad choice 8088 was for a port and we'll be moving stuff over to
8080 since that seems to go through more firewalls.

hpa is working on getting these up in some of the kernel.org sites, he's
stalled out because of some stuff he needs from me, we'll get that 
straightened out and the the authoritative source is bk.kernel.org or
master.kernel.org, I'm not quite sure.  Peter will tell you.  But we'll
keep up to date with Linus' BK tree as long as he is playing with BK
and you can follow along there.

Oh, and for what it is worth, I agree that having the changelogs as part
of the history rocks.  Goto the http://linux.bkbits.net:8088/linux-2.5
link and click on user statistics - because Linus hacked up a nice email
to patch importer script, all the patches look like they were checked
in by the person who sent them.  And it propogates down to the annotated
listings.

Here's hoping bkbits.net has gone belly up before I wake up tomorrow :-)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
