Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131793AbRAaCGy>; Tue, 30 Jan 2001 21:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135273AbRAaCGf>; Tue, 30 Jan 2001 21:06:35 -0500
Received: from cheetah.STUDENT.CWRU.Edu ([129.22.164.229]:24454 "EHLO
	cheetah.STUDENT.cwru.edu") by vger.kernel.org with ESMTP
	id <S135196AbRAaCGS>; Tue, 30 Jan 2001 21:06:18 -0500
Date: Tue, 30 Jan 2001 21:05:58 -0500 (EST)
From: Matthew Gabeler-Lee <msg2@po.cwru.edu>
X-X-Sender: <cheetah@cheetah.STUDENT.cwru.edu>
To: adrian <jimbud@lostland.net>
cc: Prasanna P Subash <psubash@turbolinux.com>, John Jasen <jjasen1@umbc.edu>,
        <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.BSO.4.30.0101302052020.1103-100000@getafix.lostland.net>
Message-ID: <Pine.LNX.4.32.0101302104360.9417-100000@cheetah.STUDENT.cwru.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, adrian wrote:

>    I have a bt848 based video capture card, and get near the same results:
> 2.4.0-test10 through 2.4.1 all lock when i2c registers the device.  The
> card has its own interrupt.  With 2.2.18, the card initialized and the
> kernel continued to boot.  Interesting.

2 questions:
What card in particular do you have?
What version of the bttv drivers were you using in 2.4.0-test10?
It comes with 0.7.38; did you patch it to a higher version?

-- 
	-Matt

Today's weirdness is tomorrow's reason why.
		-- Hunter S. Thompson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
