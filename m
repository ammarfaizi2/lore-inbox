Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154343-13684>; Wed, 6 Jan 1999 21:11:46 -0500
Received: by vger.rutgers.edu id <154352-13684>; Wed, 6 Jan 1999 08:55:40 -0500
Received: from lilly.ping.de ([195.37.120.2]:25843 "HELO lilly.ping.de" ident: "qmailr") by vger.rutgers.edu with SMTP id <154768-13684>; Wed, 6 Jan 1999 02:26:34 -0500
Message-ID: <19990106102908.A27572@kg1.ping.de>
Date: Wed, 6 Jan 1999 10:29:08 +0100
From: Kurt Garloff <K.Garloff@ping.de>
To: "B. James Phillippe" <bryan@terran.org>
Cc: Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
Mail-Followup-To: "B. James Phillippe" <bryan@terran.org>, Linux kernel list <linux-kernel@vger.rutgers.edu>
References: <19990105094830.A17862@kg1.ping.de> <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.90.4i
In-Reply-To: <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org>; from B. James Phillippe on Tue, Jan 05, 1999 at 09:25:25PM -0800
X-Operating-System: Linux 2.1.132 i686
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Jan 05, 1999 at 09:25:25PM -0800, B. James Phillippe wrote:
> I don't know anything about it (and my box is an Alpha for which HZ is
> 1024), but, one ignorant proposal: would it perhaps be worthwhile to have
> the HZ value higher for faster (x86) systems based on the target picked in
> make config?  Say, your 400 for Pentium+ and 100 for 486 or lower..?

Yes, I think this would be a good idea.
No time to code it into the CONFIG files, right now, though ...
If Linus tells me: "Hey, do it, it will be integrated then!" I will have
time, of course. 

-- 
Kurt Garloff <kurt@garloff.de>                           [Dortmund, FRG]  
Plasma physics, high perf. computing              [Linux-ix86,-axp, DUX]
PGP key on http://www.garloff.de/kurt/        [Linux SCSI driver: DC390]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
