Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWBAKDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWBAKDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWBAKDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:03:34 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:49792 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964902AbWBAKDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:03:33 -0500
Date: Wed, 1 Feb 2006 11:03:32 +0100
From: Sander <sander@humilis.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060201100332.GA14960@favonius>
Reply-To: sander@humilis.net
References: <20060131115343.GA2580@favonius> <20060131163928.GE18972@csclub.uwaterloo.ca> <20060131171723.GA6178@favonius> <20060131183013.GH18970@csclub.uwaterloo.ca> <20060131183929.GB6178@favonius> <20060131184428.GJ18970@csclub.uwaterloo.ca> <20060131185007.GD6178@favonius> <20060131185804.GM18970@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131185804.GM18970@csclub.uwaterloo.ca>
X-Uptime: 10:59:06 up 1 day, 47 min, 26 users,  load average: 0.01, 0.05, 0.06
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote (ao):
> On Tue, Jan 31, 2006 at 07:50:07PM +0100, Sander wrote:
> > Actually, I need 24 ports :-)  But 3x SX8 sets me back 540 dollars
> > according to pricewatch, which is less than half.
> 
> I know with older promise controllers, it wasn't possible to run more
> than 2 in one system as far as I remember due to some dma issues.  Not
> sure if that applies to the SX8.
> 
> If it turns out the SX8 has issues (like the one pointed out earlier
> about number of commands to the card at once) or that it can't have 3
> cards in one system at once, then what?  Are you then out $540 + the
> cost of a better controller?  Certainly worth finding out before
> spending the money.

I have a few systems which need 24 ports, so I could spread them, but
you are right of course.

> > Fakeraid controllers are less expensive, and would do too of course :-)
> 
> Of course those aren't hardware, and are only meant for small toy raids
> for windows users. The rest of use treat them as ide/sata controllers
> only.

Exactly what I need (and am looking for). An 8+ sata controller. I would
not use the fakeraid.

> I haven't seen one of those with more than 4 ports either. If
> the SX8 is one, then I must admit I haven't looked at it before. I try
> to avoid hardware from promise whenever possible.

I did too, but their attitude towards Linux seems to have changed, and I
am pretty pleased with their SATA150 TX4.

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
