Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRBEKkZ>; Mon, 5 Feb 2001 05:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbRBEKkP>; Mon, 5 Feb 2001 05:40:15 -0500
Received: from deluge.umist.ac.uk ([130.88.120.66]:53004 "EHLO
	deluge.umist.ac.uk") by vger.kernel.org with ESMTP
	id <S130317AbRBEKj5>; Mon, 5 Feb 2001 05:39:57 -0500
From: "Thomas Stewart" <T.Stewart@student.umist.ac.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Mon, 5 Feb 2001 10:41:23 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: d-link dfe-530 tx (bug-report)
CC: Urban Widmark <urban@teststation.com>,
        Jonathan Morton <chromi@cyberspace.org>, linux-kernel@vger.kernel.org,
        ksa1 <ksa1@gmx.de>
Message-ID: <3A7E8353.1100.2098EE7@localhost>
In-Reply-To: <3A7E6670.4AD21D20@colorfullife.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2001, at 9:38, Manfred Spraul wrote:

> That's expected, my patch fixes another bug.
> The NIC now recover from "Tx timeout" messages. ksa confirmed that,
> but there is still a delay of a few seconds. I'll try to fix that.
> 
> > Then I applyed your patch and still changed nothing as you
> > suspected. But there are regs that are different.
> >
> Did you run via-diag before or after loading the via-rhine module?

I compiled it into the kernel, I ran via-diag when it was working and 
when it was not working.

regards
tom

---------------------------------------------------------
 This message is ROT-13 encoded twice for extra security
 Thomas Stewart - t.stewart@student.umist.ac.uk
 This should contain no attachments
---------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
