Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbREVQXz>; Tue, 22 May 2001 12:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbREVQXp>; Tue, 22 May 2001 12:23:45 -0400
Received: from dhcp04.gb.nrao.edu ([192.33.116.206]:18180 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S262576AbREVQXe>; Tue, 22 May 2001 12:23:34 -0400
Date: Tue, 22 May 2001 12:23:29 -0400
Message-Id: <200105221623.f4MGNTa02164@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Tony Hoyle <tmh@magenta-netlogic.com>
Cc: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-ppp@vger.kernel.org
Subject: Re: ECN is on!
In-Reply-To: <3B0A8D16.2050400@magenta-netlogic.com>
In-Reply-To: <15114.18990.597124.656559@pizda.ninka.net>
	<Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu>
	<200105221306.f4MD6Pi00360@mobilix.ras.ucalgary.ca>
	<3B0A8D16.2050400@magenta-netlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle writes:
> Richard Gooch wrote:
> 
> > In fact, hopefully he's still in a dark mood, and he may take up the
> > suggestion to bounce mails of the following type:
> > - MIME encoded
> > - HTML encoded
> > - quoted printables (those stupid "=20" things are particuarly hard to
> >   read).
> 
> Surely it'd be better to get the list to filter them through stripmime?
> 
> I'd be tempted to put a message at the top at the same time:
> "*WARNING* The message below was sent by someone too clueless to 
> configure their email client properly"

Well, while that would be somewhat satisfying, there is a problem if
the message gets corrupted by this. And since some people send to the
list without being subscribed (or, like me, have duplicate filtering),
they'll never see that their message was mangled as it passed through
the list.

Nope, a bounce is better. If you're going to do these things, feedback
is essential. The bounce isn't meant to offend the sender, it's
designed to let them know what's happening.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
