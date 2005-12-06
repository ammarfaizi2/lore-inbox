Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVLFAzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVLFAzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVLFAzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:55:17 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36297 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964891AbVLFAzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:55:15 -0500
Date: Mon, 5 Dec 2005 19:54:26 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Rob Landley <rob@landley.net>
cc: Florian Weimer <fw@deneb.enyo.de>, Lee Revell <rlrevell@joe-job.com>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-Reply-To: <200512051709.08940.rob@landley.net>
Message-ID: <Pine.LNX.4.58.0512051947070.29325@gandalf.stny.rr.com>
References: <20051203135608.GJ31395@stusta.de> <873bl76zd3.fsf@mid.deneb.enyo.de>
 <1133817679.6724.52.camel@localhost.localdomain> <200512051709.08940.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Dec 2005, Rob Landley wrote:
> On Monday 05 December 2005 15:21, Steven Rostedt wrote:
> > Perhaps, we could start out having Greg and Chris just concentrate on
> > every fifth branch instead of every one, and that way the stability will
> > last much longer.
>
> Ah, belling the cat.

:)

>
> Hint:  Any plan in a volunteer community that starts with "$BUSY_PEOPLE should
> do $THIS" fails.  Any plan that starts with "I could do $THIS" at least has a
> chance.

Actually, they are already maintaining 2.6.x.y, (x => 11, 12, ...) I was
trying to get them to only maintain 2.6.x.y (x => 11, 12, 13, 14, 20, 25, ...)

So maybe it would actually be easier.  But I'm sure they wouldn't be
fooled, since the longer you maintain a fork, the harder it becomes.

I was just making a suggestion, so that if someone else thought it was a
good idea, they could do it.  I personally don't need such a beast, since
I would just stay with the latest 2.6.x anyway.  Since I have that luxury.

>
> This is not limited to open source, by the way...

Yep, I know that.

-- Steve
