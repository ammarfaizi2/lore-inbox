Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbRAIN5E>; Tue, 9 Jan 2001 08:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRAIN4y>; Tue, 9 Jan 2001 08:56:54 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:55813 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S131103AbRAIN4m>;
	Tue, 9 Jan 2001 08:56:42 -0500
Date: Tue, 9 Jan 2001 08:55:55 -0500
From: Tim Sailer <sailer@bnl.gov>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010109085555.A28548@bnl.gov>
In-Reply-To: <20010104013340.A20552@bnl.gov>, <20010104013340.A20552@bnl.gov>; <20010105140021.A2016@bnl.gov> <3A56FD6C.93D09ABB@uow.edu.au>, <3A56FD6C.93D09ABB@uow.edu.au>; <20010107235123.B6028@bnl.gov> <3A5995CF.7AEFFBBD@uow.edu.au> <20010108090644.A12440@bnl.gov> <20010108190718.Q3472@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010108190718.Q3472@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Mon, Jan 08, 2001 at 07:07:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 07:07:18PM +0100, Erik Mouw wrote:
> I had similar problems two weeks ago. Turned out the connection between
> two switches: one of them was hard wired to 100Mbit/s full duplex, the
> other one to 100Mbit/s half duplex. Just to rule out the obvious...

We check that as the first thing. Both are set the same. No collisions
out of the ordinary.

Tim

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
