Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153921-8316>; Wed, 9 Sep 1998 03:35:22 -0400
Received: from caffeine.ix.net.nz ([203.97.100.28]:4107 "EHLO caffeine.ix.net.nz" ident: "mail") by vger.rutgers.edu with ESMTP id <155207-8316>; Wed, 9 Sep 1998 01:25:54 -0400
Date: Wed, 9 Sep 1998 20:00:32 +1200
From: Chris Wedgwood <chris@cybernet.co.nz>
To: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
Message-ID: <19980909200032.B13292@caffeine.ix.net.nz>
References: <299BBE59294E@rkdvmks1.ngate.uni-regensburg.de> <98090822315400.00819@soda> <6t4ju3$gve$1@palladium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.94.5i
In-Reply-To: <6t4ju3$gve$1@palladium.transmeta.com>; from H. Peter Anvin on Wed, Sep 09, 1998 at 12:59:47AM +0000
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Sep 09, 1998 at 12:59:47AM +0000, H. Peter Anvin wrote:

> The way xntp deals with leap seconds is it lets the epoch float...
> i.e. it holds time_t to the same value for two seconds.

Cool... so 1970 becomes even longer ago that I would have assumed
then?



-cw



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
