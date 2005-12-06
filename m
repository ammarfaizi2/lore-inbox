Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbVLFDZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVLFDZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVLFDZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:25:07 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3760 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751504AbVLFDZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:25:05 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 21:22:13 -0600
User-Agent: KMail/1.8
Cc: Florian Weimer <fw@deneb.enyo.de>, Lee Revell <rlrevell@joe-job.com>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <200512051709.08940.rob@landley.net> <Pine.LNX.4.58.0512051947070.29325@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0512051947070.29325@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052122.13700.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 18:54, Steven Rostedt wrote:

> > Hint:  Any plan in a volunteer community that starts with "$BUSY_PEOPLE
> > should do $THIS" fails.  Any plan that starts with "I could do $THIS" at
> > least has a chance.
>
> Actually, they are already maintaining 2.6.x.y, (x => 11, 12, ...) I was
> trying to get them to only maintain 2.6.x.y (x => 11, 12, 13, 14, 20, 25,
> ...)

That's still "trying to get them" rather than "I could"...

> So maybe it would actually be easier.  But I'm sure they wouldn't be
> fooled, since the longer you maintain a fork, the harder it becomes.

And the number exponentially increases (2.6.x+1.y, 2.6.x+2.y, all at the same 
time...)

No, I pestered them a while back about possibly doing a 2.6.x.y+1 to flush 
their patch queue before doing a 2.6.x+1.1, and they seem more receptive to 
the idea now.  But then backporting 2.6.x+1.y to 2.6.x becomes your job...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
