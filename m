Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTBMQ4i>; Thu, 13 Feb 2003 11:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbTBMQ4i>; Thu, 13 Feb 2003 11:56:38 -0500
Received: from havoc.daloft.com ([64.213.145.173]:58823 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267534AbTBMQ4h>;
	Thu, 13 Feb 2003 11:56:37 -0500
Date: Thu, 13 Feb 2003 12:06:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Paul Larson <plars@linuxtestproject.org>,
       Edesio Costa e Silva <edesio@ieee.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Edesio Costa e Silva <edesio@task.com.br>
Subject: Re: 2.5.60 cheerleading...
Message-ID: <20030213170623.GA26822@gtf.org>
References: <3E4A6DBD.8050004@pobox.com> <1045075415.22295.46.camel@plars> <20030212173300.A31055@master.softaplic.com.br> <1045150153.28493.10.camel@plars> <20030213160300.GB2070@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213160300.GB2070@codemonkey.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 04:03:00PM +0000, Dave Jones wrote:
> On Thu, Feb 13, 2003 at 09:29:12AM -0600, Paul Larson wrote:
>  > It would be nice if that were true, but back here in reality things are
>  > rarely if ever even stable enough for testing if they merely build and
>  > boot.
>  > 
>  > If Linus really is building and booting every kernel prior to release,
>  > it would be quick and simple to add a fast subset of LTP to the mix and
>  > do a quick regression run.  It's convenient, fast and could save a lot
>  > of headaches for a lot of people later on.
> 
> Nothing stops people from LTPtesting the -bk nightlies.
> Sure, they won't catch the last-minute-torvalds-breaks-the-compile
> type bugs, but for the most part it should be useful enough info.

Agreed... at least the past few releases, the just-after-the-release BK
snapshot often compiles and boots more reliably than the release <g>

Current 2.5.60-BK is looking _really_ nice, LTP-wise.

	Jeff



