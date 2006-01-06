Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWAFRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWAFRyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWAFRyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:54:35 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:15078 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964808AbWAFRye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:54:34 -0500
Subject: Re: [Announce] RT patch updates while Ingo is busy
From: Steven Rostedt <rostedt@goodmis.org>
To: Rick Wright <riwright@vt.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <43BEA35D.5030301@vt.edu>
References: <200601041832.39089.Serge.Noiraud@bull.net>
	 <Pine.LNX.4.64.0601041234130.22025@dhcp153.mvista.com>
	 <1136412737.12468.92.camel@localhost.localdomain>
	 <1136427110.12468.112.camel@localhost.localdomain>
	 <43BEA35D.5030301@vt.edu>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 12:54:28 -0500
Message-Id: <1136570068.12468.149.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 12:05 -0500, Rick Wright wrote:
> Steve,
> 
> I noticed that 2.6.15-rc2 was released in Ingo's usual place yesterday
> (1/5/06) which seems to post-date your 2.6.15-rcX-srX branch.  Then,
> earlier today you hinted at an impending 2.6.15-rc1-sr2 release.
> Could you explain how your patches are related to Ingo's -rc2 patch as
> they seem to be somewhat interleaved?

My patches are for going between Ingo's releases.  I've even released
2.6.15-rt1-sr2, for the simple reason I didn't notice that 2.6.15-rt2
was out :)

So I'll now download 2.6.15-rt2 and see where it's at. So my suggestion
is to always pick the latest -rt kernel, and if it doesn't work, try my
-sr patch for the same release.

> 
> Also, I didn't include the other's on this mail or cc LKML as I'm not
> sure if this was appropriate.  If you believe others should be
> included, please include them and forgive my exclusion.

I've added both Ingo and the lkml just so others know.  As the title
says, the -sr branch is only while Ingo is busy doing other things, but
I'll keep my branches posted anyways.

-- Steve


