Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAED1I>; Thu, 4 Jan 2001 22:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAED06>; Thu, 4 Jan 2001 22:26:58 -0500
Received: from femail7.sdc1.sfba.home.com ([24.0.95.87]:62155 "EHLO
	femail7.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129267AbRAED0v>; Thu, 4 Jan 2001 22:26:51 -0500
Message-ID: <002201c076c7$76cab720$8d19b018@c779218a>
From: "Nicholas Knight" <tegeran@home.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14EMpJ-0006ty-00@the-village.bc.nu>
Subject: Re: Change of policy for future 2.2 driver submissions
Date: Thu, 4 Jan 2001 19:27:42 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, January 04, 2001 6:41 PM
Subject: Change of policy for future 2.2 driver submissions


>
> Linux 2.4 is now out, it is also what people should be concentrating on
first
> when issuing production drivers and driver updates. Effective from this
point
> 2.2 driver submissions or major driver updates will only be accepted if
the
> same code is also available for 2.4.
>
> Someone has to do the merging otherwise, and it isnt going to be me...

This is the first time I'll have sent anything to this list, and I hadn't
planned on sending anything for a long time to come, but I think in this
case I must toss in my 2cents.
While I understand the reasoning behind this, and might do the same thing if
I was in your position, I feel it may be a mistake.
I personaly do not trust the 2.4.x kernel entirely yet, and would prefer to
wait for 2.4.1 or 2.4.2 before upgrading from 2.2.18 to ensure last-minute
wrinkles have been completely ironed out, and I know there are people who
share my viewpoint, and would rather use 2.2.XX for a while yet, and I'm
afraid that this may partialy criple 2.2 driver development.
It can take little or a lot of time to port a driver from 2.2 to 2.4, and in
some cases people may just not want to do it untill 2.4 has gone through a
little more refining, and that could take a while.

To sum it up, I just don't think this is the right decision to make, at
least not yet.
My opinion probably won't matter one bit, but I thought I might as well toss
it out there.

-NK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
