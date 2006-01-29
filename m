Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWA2FBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWA2FBc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 00:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWA2FBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 00:01:32 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:4023 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1750825AbWA2FBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 00:01:31 -0500
Date: Sat, 28 Jan 2006 21:02:16 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       davej@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
In-Reply-To: <20060128204531.4786aaea.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.63.0601282053170.7205@localhost.localdomain>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
 <20060128204531.4786aaea.rdunlap@xenotime.net>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006, Randy.Dunlap wrote:

> On Sat, 28 Jan 2006 20:30:25 -0800 (PST) Chuck Wolber wrote:
> 
> > On Fri, 27 Jan 2006, Greg KH wrote:
> > 
> > > This is the start of the stable review cycle for the 2.6.14.7 
> > > release. There are 6 patches in this series, all will be posted as a 
> > > response to this one.  If anyone has any issues with these being 
> > > applied, please let us know.  If anyone is a maintainer of the 
> > > proper subsystem, and wants to add a signed-off-by: line to the 
> > > patch, please respond with it.
> > 
> > Please correct me if I'm wrong here, but aren't we supposed to stop 
> > doing this for the 2.6.14 release now that 2.6.15 is out?
> 
> Some people wanted more -stable so the stable team agreed to do a little 
> more.  Is it a problem?


I don't know if there is a problem, but it goes against the concept of 
"one-off" fixes that aren't maintained (aka the purpose of the -stable 
team). This slope eventually leads us to backporting -stable fixes from 
other -stable releases etc etc. 

If there's one thing I've learned from watching guys like Alan Cox 
maintain stable releases, it's that they're profoundly good at saying 
"no". I'm not saying that's warranted here, I'm just trying to encourage 
the dialog (I suspect that I've missed part of the conversation as I am 
not currently subscribed to LKML).

..Chuck..


-- 
http://www.quantumlinux.com
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply
  social values more noble than mere monetary profit." - FDR
