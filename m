Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbRBMOQj>; Tue, 13 Feb 2001 09:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRBMOQT>; Tue, 13 Feb 2001 09:16:19 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:11076 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S131116AbRBMOQP>;
	Tue, 13 Feb 2001 09:16:15 -0500
Message-ID: <XFMail.20010213141110.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <E14SfKk-0001kl-00@the-village.bc.nu>
Date: Tue, 13 Feb 2001 14:11:10 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Feb-2001 Alan Cox wrote:
>> Having experienced a number of crashes with Xfree 4.0 with 2.4
>> kernels, that I wasn't getting with 2.2 kernels, a quick search on
>> the xfree Xpert mailing list reveals this:
> 
> Yeah I've seen this claim repeatedly. XFree 4.0.2 crashes for me in
> similar
> ways on 3dfx and matrox cards and it happens with 2.2 kernels as
> well.

Mine's rock solid with 2.2 though. I have two Matrox Millennium IIs
multi-headed, on SMP - asking for trouble :-)

> 
> I believe it to be Xfree or glibc problems.  So I'm not. Since I
> can't get
> XFree 4 stable on 2.2 I dont have a useful setup to study this.
> 

I've had a report that 2.4.2pre3 has sorted out the problem, so am
trying that. Grabs straw: maybe the VM accounting changes have helped?

-tony


---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
Q:	What's the difference between a dead dog in the road and a dead
	lawyer in the road?
A:	There are skid marks in front of the dog.

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
