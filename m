Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282932AbRLCJKy>; Mon, 3 Dec 2001 04:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282083AbRLCJKI>; Mon, 3 Dec 2001 04:10:08 -0500
Received: from ns.etm.at ([212.88.180.5]:48139 "EHLO etm.at")
	by vger.kernel.org with ESMTP id <S281862AbRLCJIO>;
	Mon, 3 Dec 2001 04:08:14 -0500
Message-Id: <01Dec3.100854cet.117132@fwetm.etm.at>
From: "Stanislav Meduna" <stano@meduna.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200112030244.fB32iMx4024126@sleipnir.valparaiso.cl>
Subject: Re: Coding style - a non-issue 
Date: Mon, 3 Dec 2001 10:07:59 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Msmail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> Have you got any idea how QA is done in closed environments?

Yes I do. I write commercial sofware for 10 years and have
experience with QA systems in two companies, one of them
major. I think I have seen the full range of QA in various projects -
from a complete negation to a silly buerocratic inefficient one.

> Complex software *has* bugs, bugs which aren't apparent
> except under unsusual circumstances are rarely found in the
> first round of bug chasing.

Sure. But we now have 2.4.16, not 2.4.0 and guess what? -
there is a big thread about fs corruption going right now
in the l-k  :-( This should _not_ happen in the stab{le,ilizing}
series and if it happened, the cause should be identified
and measures taken.

I for one think that the kernel has overgrown its current
development model and that some _incremental_ steps
in the direction of both more formal control and delegation
of responsibilities are needed. I think that the most active
kernel developers should discuss the future of the development
model, as they are the only ones that can really come up
with a solution.

It is of course only my opinion - if I am alone having it, forget it.

> > As a user of the vendor's kernel I have no idea what to do
> > with a bug.
> 
> Report it to the vendor, through the documented channels?

Did this. It is two months, I did some cornering of the problem
and augmented the report several times. The issue is still NEW,
without any response asking to try a patch, supply more details
or such. Yes, this speaks more of the vendor than of the Linux.
But what impression do you think the average user gets from
such experience?

Regards
-- 
                                                       Stano


