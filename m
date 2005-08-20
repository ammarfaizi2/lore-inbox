Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932812AbVHTDEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbVHTDEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbVHTDEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:04:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22979 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932812AbVHTDEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:04:21 -0400
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4
	for 2.6.12 and 2.6.13-rc6
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200508201031.59981.kernel@kolivas.org>
References: <43001E18.8020707@bigpond.net.au>
	 <200508191436.42881.kernel@kolivas.org>
	 <1124482411.25424.49.camel@mindpipe>
	 <200508201031.59981.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 23:04:18 -0400
Message-Id: <1124507059.25916.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 10:31 +1000, Con Kolivas wrote:
> On Sat, 20 Aug 2005 06:13, Lee Revell wrote:
> >
> > I agree that tweaking the scheduler is probably pointless, as long as X
> > is burning gazillions of CPU cycles redrawing things that don't need to
> > be redrawn.
> >
> > Then again even the OSX scheduler has hooks for the GUI.  Presumably
> > they concluded that the desktop responsiveness problem could not be
> > adequately solved within the framework of a general purpose UNIX
> > scheduler.
> 
> It's an X problem and it's being fixed. Get over it, we're not tuning the 
> scheduler for a broken app.

I wasn't saying it would be a smart thing to do, the OSX thing is
interesting that's all.  I think we're in violent agreement about the X
problem, do you have a link to any specific work on this (off list)?

Lee

