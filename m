Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVLSB7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVLSB7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVLSB7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:59:24 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34002 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030211AbVLSB7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:59:24 -0500
Date: Sun, 18 Dec 2005 20:59:11 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "K.R. Foley" <kr@cybsft.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-rt2 won't boot on dual 933
In-Reply-To: <43A60630.4070304@cybsft.com>
Message-ID: <Pine.LNX.4.58.0512182056010.10119@gandalf.stny.rr.com>
References: <43A5DAE4.8090908@cybsft.com> <1134953473.13138.217.camel@localhost.localdomain>
 <43A60630.4070304@cybsft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Dec 2005, K.R. Foley wrote:

> >
> > KR,
> >
> > Does your kernel boot without CONFIG_DEBUG_PREEMPT?
> >
> > -- Steve
>
> No. Already tried and got a different dump. Not sure if it was just a
> dump or a dump initiated by an oops. In an hour or so I will go down and
> capture that.
>

In a hour or so, I will be in bed.  I'll look at it tomorrow, I have too
much on my plate to pull an "Ingo" and stay up till (what?) 4am pumping
out patches (Actually, I did that last night).

Way to go Ingo!  I'll take a closer look at all your stuff tomorrow.

kr, I'll look at your capture tomorrow as well.  I'll try to do what I
can and give Ingo a break.  He deserves it.

-- Steve

