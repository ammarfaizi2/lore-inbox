Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbQLEPi6>; Tue, 5 Dec 2000 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbQLEPis>; Tue, 5 Dec 2000 10:38:48 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:5831 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131150AbQLEPiq>; Tue, 5 Dec 2000 10:38:46 -0500
Message-ID: <3A2D0493.55AED90C@inet.com>
Date: Tue, 05 Dec 2000 09:06:59 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Reitz <areitz@uiuc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Assistance requested in demystifying wait queues.
In-Reply-To: <Pine.SOL.4.30.0012042358270.19766-100000@stellar.cso.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Reitz wrote:
> 
> Hello,
> 
> I'm absolutely green when it comes to Linux kernel development, and so
> working on a school project to port a TCP/IP-based service into the kernel
> has been quite challenging (but also intesting)! Currently, I'm absolutely
> mystified regarding how the "wait queue" subsystem works. I've been
> reading the code, and usually that combined with an example is enough,
> but not this time.

Andy,

Go get "Linux Device Drivers" by Rubini (O'Reilly).  It talks about that
and a lot of other useful stuff.  Some of it is a bit dated by
development in 2.2 & 2.[34], but it'll help a lot.

Good luck,

Eli
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
