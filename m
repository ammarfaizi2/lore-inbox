Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264250AbTCXPaG>; Mon, 24 Mar 2003 10:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264251AbTCXPaG>; Mon, 24 Mar 2003 10:30:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3291 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264250AbTCXPaE>; Mon, 24 Mar 2003 10:30:04 -0500
Date: Mon, 24 Mar 2003 07:40:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: jgarzik@pobox.com, rml@tech9.net, mj@ucw.cz, alan@redhat.com, pavel@ucw.cz,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <85710000.1048520457@[10.10.2.4]>
In-Reply-To: <20030324113035.540cfd25.skraw@ithnet.com>
References: <29100000.1048459104@[10.10.2.4]><3E7E3AF0.6040107@pobox.com>
 <1940000.1048460794@[10.10.2.4]> <20030324113035.540cfd25.skraw@ithnet.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> _please_ be honest and realistic: we are talking about the problem of
> vendors forking around yakr (Yet Another Kernel Release) and you really
> say "lets solve it all with _another_ fork" ?? Come on, don't be silly
> (tm Linus). Let's focus and not fork. There _are_ issues with 2.4, but
> they are getting solved bit-by-bit. It would be faster of course if we
> all would concentrate on the _mainline_ and not on yet-another patchlist,
> split-tree or whatever.

I see your point, and I'd love to get this stuff merged back to mainline
2.4, and that would actually be the whole point of doing this ... to
provide a channel of stuff that should get merged back. The other thing to
bear in mind is that what I want is not really another to turn 4 branches
into 5, it's to turn 4 branches into two branches with a couple of twigs
off each ;-) So I actually want *more* commonality.
 
> Another thing has already been talked about here, so lets talk real open
> about it: some of us are living in the strong impression that Marcelo has
> problems with the pure time working on maintaining. I do not know
> anything about the backgrounds, but if this is really true, then let _me_
> ask Conectiva if there is a chance that he can do the maintaining
> full-time. I mean this is for sure one of the interesting PR activities,
> too. After all those years it is still true: there can be only one.
> Of course this only makes sense if he still really wants to do that. _Me_
> asking this because I am in no way related to any other distro, vendor or
> Marcelo, just being the "linux-enthusiast from next-door" (with management
> background ;-). 

If Marcelo would like some more help from others for integration / testing
whatever, I'm sure it could be arranged if he described what he'd like. I
know that helps me out a lot at least if I can get others to help me ...
(eg. take these 5 patches, merge them on top of my latest prerelease, and
kick the snot of them for me to see if they're basically looking OK). 

There's plenty of talent and enthusiasm around on LKML that's able to share
the burden ... would be much more constructive than us (myself included)
complaining ;-)

M.

PS. If Andrea's VM fixes are a good candidate, that people are seriously
interested in, I'll get myself and others here to give them a beating.
