Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <157344-13684>; Thu, 7 Jan 1999 14:55:12 -0500
Received: from caffeine.ix.net.nz ([203.97.100.28]:1200 "EHLO caffeine.ix.net.nz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157670-13684>; Thu, 7 Jan 1999 02:30:21 -0500
Date: Thu, 7 Jan 1999 22:56:04 +1300
From: Chris Wedgwood <cw@ix.net.nz>
To: "B. James Phillippe" <bryan@terran.org>
Cc: Kurt Garloff <K.Garloff@ping.de>, Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
Message-ID: <19990107225604.B1900@caffeine.ix.net.nz>
References: <19990105094830.A17862@kg1.ping.de> <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
In-Reply-To: <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org>; from B. James Phillippe on Tue, Jan 05, 1999 at 09:25:25PM -0800
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Jan 05, 1999 at 09:25:25PM -0800, B. James Phillippe wrote:

> I don't know anything about it (and my box is an Alpha for which HZ
> is 1024), but, one ignorant proposal: would it perhaps be
> worthwhile to have the HZ value higher for faster (x86) systems
> based on the target picked in make config?  Say, your 400 for
> Pentium+ and 100 for 486 or lower..?

I musted have missed the reset of this thread -- what exactly are
people wanting to acheive with a higher timer frequency?



-cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
