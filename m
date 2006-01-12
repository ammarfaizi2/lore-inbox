Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbWALVFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWALVFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWALVFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:05:23 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:44746 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932676AbWALVFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:05:23 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Lee Revell <rlrevell@joe-job.com>
To: David Nicol <davidnicol@gmail.com>
Cc: Yaroslav Rastrigin <yarick@it-territory.ru>, CaT <cat@zip.com.au>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <934f64a20601121053q38e191c6y5c9ac00a68a49bf2@mail.gmail.com>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091403.46304.yarick@it-territory.ru>
	 <20060109124545.GA2035@zip.com.au>
	 <200601091634.52107.yarick@it-territory.ru>
	 <934f64a20601101829q1f801a0y8efc2988489b6d9a@mail.gmail.com>
	 <1136948198.2007.137.camel@mindpipe>
	 <934f64a20601121053q38e191c6y5c9ac00a68a49bf2@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 16:05:18 -0500
Message-Id: <1137099918.2370.59.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 12:53 -0600, David Nicol wrote:
> On 1/10/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Tue, 2006-01-10 at 20:29 -0600, David Nicol wrote:
> > > On 1/9/06, Yaroslav Rastrigin <yarick@it-territory.ru> wrote:
> > >
> > > > Unfortunately, bounties doesn't work :-/
> > >
> > >
> > > No?  Bounties seems to work fine for Asterisk.  Is the problem, still no central
> > > linux kernel bounty system?
> >
> >
> > Many bounties don't work because they are too low, too vague or both.
> > For example several months ago Ubuntu offered $500 to "fix all remaining
> > ALSA issues for PowerMac hardware".  HA!  That's like 5 or 6 diffent
> > drivers which ranged from not working at all, to sound works but no
> > system beeps, etc...
> >
> > Lee
> 
> 
> How did they offer this bounty?  Through the ubuntu announcements channels?
> 
> Like if, say, Linux International was to partner with TipJar.com to create
> and maintain an organized open bounty system where stakeholders wanting
> to see something could contribute to the pot for the feature and the first
> implementor who passes the tests (including code readability!) gets the pot.
> 
> Write me off-list to become involved in this project or to direct me to
> an already existing project so I don't waste more time on wheel reinvention?

Heh, I only found out about it when some Ubuntu user mentioned it in an
ALSA bug report.  I guess they just expect people to find them somehow.
So yes, there needs to be a single, central resource for OSS bounties.

I think a lot of these problems with the PPC drivers were later solved.
But my point was really that $500 was not nearly enough for the amount
of work that would have been required.  It's a nice bonus for someone
who would have done it for free anyway but I was under the impression
that bounties were created to solve problems too tricky or unrewarding
or uninteresting for someone to do for free.

Lee


