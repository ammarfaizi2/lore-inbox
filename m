Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289297AbSA3Pgg>; Wed, 30 Jan 2002 10:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289301AbSA3Pg0>; Wed, 30 Jan 2002 10:36:26 -0500
Received: from waste.org ([209.173.204.2]:37298 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289297AbSA3PgT>;
	Wed, 30 Jan 2002 10:36:19 -0500
Date: Wed, 30 Jan 2002 09:36:12 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Chris Funderburg <Chris@Funderburg.com>
cc: "'Jeff Garzik'" <garzik@havoc.gtf.org>,
        "'Daniel Phillips'" <phillips@bonn-fries.net>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: bug tracking (was Re: A modest proposal -- We need a patch
 penguin)
In-Reply-To: <000901c1a96f$13963680$0105360a@bti.com>
Message-ID: <Pine.LNX.4.44.0201300921300.1957-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Chris Funderburg wrote:

> Wouldn't Bugzilla be perfect for this?  I run a slightly modified
> version for the company I work for.  You could have as many
> administrators as you need, and use categories for different kernel
> subsystems.  The maintainers could be set-up as QA contacts, and it's
> really easy to maintain.

Bugzilla would be fine. But the tools alone are only a small part of the
problem. Good bug tracking requires people to enter good bug descriptions,
and sift through the database and remove duplicates, close old bugs,
adjust priorities, etc. I personally loathe such work even though I
recognize the value of it, and I suspect most of the major maintainers do
too. The problem is, they're the ones getting the bug reports. We have to
move from the current situation to one where there are trusted and
effective bug database trackers receiving the reports and that's a pretty
big transition.

Note that MJC already has a bugzilla up for his tree. Don't know if he's
found someone to manage it yet though. If that Bugzilla were to track,
say, the dj tree and the rmap patch too, it might get closer to critical
mass. Redhat's already got a Bugzilla for their mostly AC kernel, and
they might be willing to copy mainline kernel bugs to another Bugzilla.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

