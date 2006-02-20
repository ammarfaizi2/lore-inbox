Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWBTNa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWBTNa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWBTNa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:30:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:738 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030217AbWBTNa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:30:58 -0500
Date: Mon, 20 Feb 2006 14:30:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Matthias Hensler <matthias@wspse.de>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220133049.GE23277@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <200602202038.21559.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202038.21559.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> On Monday 20 February 2006 20:06, Lee Revell wrote:
> > On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > These "big changes" is something I have a problem with, since it means
> > > to delay a working suspend/resume in Linux for another
> > > "short-term" (so
> > > what does it mean: 1 month? six? twelve?). It is painful to get these
> > > things to work reliable, I have followed this for nearly 1.5 years.
> > > And
> > > again: today there is a working implementation, so why not merge it
> > > and
> > > have something today, and then start working on the other things.
> >
> > It never works that way in practice - if you let broken/suboptimal code
> > into the kernel then it's a LOT less likely to get fixed later than if
> > you make fixing it a condition of inclusion because once it's in there's
> > much less motivation to fix it.
> 
> I can be an exception, can't I?

I do not trust you to be an exception, sorry. Your behaviour up to now
also suggests you will not be.
								Pavel
-- 
Thanks, Sharp!
