Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUJORpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUJORpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJORmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:42:22 -0400
Received: from brown.brainfood.com ([146.82.138.61]:27264 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268285AbUJORkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:40:33 -0400
Date: Fri, 15 Oct 2004 12:40:16 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Dominik Karall <dominik.karall@gmx.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
In-Reply-To: <1097858925.4904.10.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0410151239360.1219@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> 
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> 
 <200410151359.20816.dominik.karall@gmx.net> <1097858925.4904.10.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Lee Revell wrote:

> On Fri, 2004-10-15 at 07:59, Dominik Karall wrote:
> > On Friday 15 October 2004 12:26, Ingo Molnar wrote:
> > > i have released the -U3 PREEMPT_REALTIME patch:
> > >
> > >
> > > http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-
> > >U3
> >
> > hi ingo!
> > can you change your version string to lower case letters to avoid "problems"
> > with make-kpkg?
> > if not, no problem...
>
> Please file a Debian bug report.  make-kpkg should be able to handle
> this.

Yes and no.  Package names in debian must be lowercase.  Of course, make-kpkg
could always do a lowercase on the string.  shrug.

ps: Speaking with my dpkg hat on.
