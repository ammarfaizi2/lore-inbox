Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVLFB0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVLFB0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVLFB0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:26:41 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56793 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964900AbVLFB0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:26:41 -0500
Date: Mon, 5 Dec 2005 20:26:12 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Florian Weimer <fw@deneb.enyo.de>
cc: Rob Landley <rob@landley.net>, Lee Revell <rlrevell@joe-job.com>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-Reply-To: <873bl72fpt.fsf@mid.deneb.enyo.de>
Message-ID: <Pine.LNX.4.58.0512052018290.29880@gandalf.stny.rr.com>
References: <20051203135608.GJ31395@stusta.de> <873bl76zd3.fsf@mid.deneb.enyo.de>
 <1133817679.6724.52.camel@localhost.localdomain> <200512051709.08940.rob@landley.net>
 <Pine.LNX.4.58.0512051947070.29325@gandalf.stny.rr.com> <873bl72fpt.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Florian Weimer wrote:
> >
> > Actually, they are already maintaining 2.6.x.y, (x => 11, 12, ...)
>
> I think the 2.6.x.y series is no longer maintained once 2.6.x+1 has
> been released for some time (surely after 2.6.x+2).
>

The same can still go for this, but instead of stopping at 2.6.x+2 we could
stop at 2.6.x+6 (or +5), and just not care about 2.6.x+[1-4].  But that
would be strong enough for those that would like the stable branch to
maintain it themselves.  Currently it'l hard to pick a 2.6.x that you want
to stay with since the 2.6.x.y is stopped right after 2.6.x+1 is out.  But
if not all 2.6.x has a .y, then that would focus more distrobutions or
whatever to pick the same one to support.

Oh well, I'm just spitting out a bunch of lip service here. It actually
seems interesting to try, and if I actually had a need to do this, I
would. But right now my focus is elsewhere.

Cheers,

-- Steve

