Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEGh5>; Fri, 5 Jan 2001 01:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRAEGhs>; Fri, 5 Jan 2001 01:37:48 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:30322 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129267AbRAEGhj>;
	Fri, 5 Jan 2001 01:37:39 -0500
Message-ID: <3A556BF2.AD3860A6@Rikers.org>
Date: Thu, 04 Jan 2001 23:38:42 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nicholas Knight <tegeran@home.com>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <E14EMpJ-0006ty-00@the-village.bc.nu> <002201c076c7$76cab720$8d19b018@c779218a>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas,

While I can see what you are asking, here are some comments in Alan's
favor:

He did not say people can not release 2.2 patches without 2.4 patches.
He only said they will not be integrated into the kernel distribution
without 2.4 patches.

If people continue to develop for 2.2 and have someone else, who is
probably less familiar with the hardware, port to 2.4 for them, how soon
would you trust the drivers over the 2.2 drivers?

In short, I agree with Alan completely. This is the correct move forward
to cause 2.4 to become the stable release that everyone will be willing
to adopt.

Nicholas Knight wrote:
> 
> ----- Original Message -----
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, January 04, 2001 6:41 PM
> Subject: Change of policy for future 2.2 driver submissions
> 
> >
> > Linux 2.4 is now out, it is also what people should be concentrating on
> first
> > when issuing production drivers and driver updates. Effective from this
> point
> > 2.2 driver submissions or major driver updates will only be accepted if
> the
> > same code is also available for 2.4.
> >
> > Someone has to do the merging otherwise, and it isnt going to be me...
> 
> This is the first time I'll have sent anything to this list, and I hadn't
> planned on sending anything for a long time to come, but I think in this
> case I must toss in my 2cents.
> While I understand the reasoning behind this, and might do the same thing if
> I was in your position, I feel it may be a mistake.
> I personaly do not trust the 2.4.x kernel entirely yet, and would prefer to
> wait for 2.4.1 or 2.4.2 before upgrading from 2.2.18 to ensure last-minute
> wrinkles have been completely ironed out, and I know there are people who
> share my viewpoint, and would rather use 2.2.XX for a while yet, and I'm
> afraid that this may partialy criple 2.2 driver development.
> It can take little or a lot of time to port a driver from 2.2 to 2.4, and in
> some cases people may just not want to do it untill 2.4 has gone through a
> little more refining, and that could take a while.
> 
> To sum it up, I just don't think this is the right decision to make, at
> least not yet.
> My opinion probably won't matter one bit, but I thought I might as well toss
> it out there.
> 
> -NK
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
