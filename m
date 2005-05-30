Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVE3M42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVE3M42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVE3M42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:56:28 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:55815 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261522AbVE3M4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:56:25 -0400
Date: Mon, 30 May 2005 06:01:09 -0700
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Valdis.Kletnieks@vt.edu, Lee Revell <rlrevell@joe-job.com>,
       Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530130109.GA8565@nietzsche.lynx.com>
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com> <1117334933.11397.21.camel@mindpipe> <Pine.LNX.4.61.0505282054540.12903@montezuma.fsmlabs.com> <200505290408.j4T487n6024489@turing-police.cc.vt.edu> <Pine.LNX.4.61.0505290856220.12903@montezuma.fsmlabs.com> <200505291750.j4THoUWW010374@turing-police.cc.vt.edu> <Pine.LNX.4.61.0505291223120.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505291223120.12903@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 01:52:45PM -0600, Zwane Mwaikambo wrote:
> On Sun, 29 May 2005 Valdis.Kletnieks@vt.edu wrote:
> > but the 40,000 people who buy 4/8 channel mixers aren't" - by your standards,
> > nobody's interested in 48-channel mixing boards either.
> 
> I seem to have gotten you rather excited, you've actually gone as far as 
> creating a strawman argument for my allegedly "strawman" statement. What 
> i originally stated was that media applications are not common place as far 
> as _hard_ realtime systems are concerned, this was in reply to Bill's 
> emphasis on media applications. Now i'm not trying to undermine the 

Zwane,

They are common to folks wanting to playing back any kind of video image
with reasonable quality. What's happened is that sloppy apps are using
slopping OSes to create one big glitchfest that consumers are use to.
Coming from an old SGI background I know how idiotic this is. Yes,
RTOSes aren't used for media applications, not because its exotic, but
because most folks that are Microsoft influence, includes Linux, can't
write decent media apps even if IRIX and the sources for the apps are
handle to them.

> audiophiles' goals or aspirations and i do indeed see the benefits for 
> them but in the event of Linux becoming an RTOS, the main fields 
> of interest wouldn't be from media application providers (even if there 
> certainly will be an increase in their interest).

This would changes it. RTOS companies are typically are driven by
defense contracts and the like which is a culture that encourages
consumer technologies like this to be developed. If you give apps folks
the necessary tools, combine that with the knowledge, then this would
be much more prevalent as a base level of performance for these apps.

If anything media apps have been sucky for the very reason Valdis
previously described.

bill

