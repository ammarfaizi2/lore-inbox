Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154752-662>; Fri, 9 Oct 1998 10:08:18 -0400
Received: from ps.cus.umist.ac.uk ([192.84.78.160]:25858 "EHLO ps.cus.umist.ac.uk" ident: "rhw") by vger.rutgers.edu with ESMTP id <156218-662>; Fri, 9 Oct 1998 08:46:25 -0400
Date: Fri, 9 Oct 1998 19:20:33 +0100 (GMT)
From: Riley Williams <rhw@bigfoot.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: network nicety
In-Reply-To: <m0zRfh1-0007U1C@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.981009191551.26970I-100000@ps.cus.umist.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi Alan.

On Fri, 9 Oct 1998, Alan Cox wrote:

 >> Sure - you're saying that just because you're downloading an
 >> application for a customer, nobody else should be able to use that
 >> link - and I have to say that I disagree with that viewpoint.

 > TCP/IP doesnt claim to be fair

True, but irrelevant - whether or not TCP/IP is fair has no bearing on
whether the users should show the sort of greed implied by the message
I replied to...

 >> IMHO, the fact that an FTP transfer will automatically grab 100% of
 >> the bandwidth of one's primary link given the slightest chance can
 >> only be bad - and the same applies to any other protocol. What I'd
 >> like to see is some form of bandwidth limiting system which prevents
 >> any one protocol from grabbing more than 90% of the bandwidth to
 >> itself, but which allows any protocol to use all otherwise unused
 >> bandwidth if it needs it, but automatically relinquishes the excess
 >> bandwidth as soon as anything else needs it.

 > Its called CBQ and Linux 2.1.x supports it.

Two points here.

 1. It's good to know that such a thing exists.

 2. Does Linux apply it automatically when the remote end is also a
    Linux system? If not, there's little incentive for others to
    also support it.

 > Don't expect ISP end user ports to support it in the next 5 years
 > however, $10/month customers arent worth the CPU cost of such
 > things

Somehow, that doesnae surprise me...

Best wishes from Riley.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
