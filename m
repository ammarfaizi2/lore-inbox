Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUEQWjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUEQWjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUEQWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:39:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21655 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262451AbUEQWdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:33:03 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Norman Diamond" <ndiamond@despammed.com>,
       "Roland Dreier" <roland@topspin.com>
Subject: Re: [patch] kill off PC9800
Date: Tue, 18 May 2004 00:33:23 +0200
User-Agent: KMail/1.5.3
Cc: "Adrian Bunk" <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
References: <035e01c43b18$69ede9f0$b7ee4ca5@DIAMONDLX60> <5265auu3i1.fsf@topspin.com> <05af01c43c5a$786e6340$b7ee4ca5@DIAMONDLX60>
In-Reply-To: <05af01c43c5a$786e6340$b7ee4ca5@DIAMONDLX60>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405180033.23202.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just to get back on topic...

We want to kill PC9800 port because it is a dead code
(unfinished and unmaintained) but developers still have
to waste time on updating it while making some unrelated
changes.

It has nothing to do with not liking PC9800 hardware
or thinking that it is obsolete.

PPC port in contrary to PC9800 one has very active developers.

On Monday 17 of May 2004 23:59, Norman Diamond wrote:
> Roland Dreier replied to me:
> >     Norman> I'll bet that the number of PC9800 machines still in
> >     Norman> existence is an order of magnitude larger than the number
> >     Norman> of PowerPC machines still in existence (including current
> >     Norman> ones).
> >
> > Do you realize that every Apple Macintosh sold for about the last 10
> > years is PowerPC-based?
>
> Do you realize that Apple's market share is still less than NEC's?  And if
> you want to go back 10 years, NEC had about 90% of the PC market and they
> were all 9800 series.
>
> > Not to mention all of IBM's midrange-servers
> > (p and i series).  Plus a huge embedded presense.
>
> OK, NEC's servers are not PCs.  (Or at least they didn't used to be.)  But
> their numbers hardly affect PC statistics.

