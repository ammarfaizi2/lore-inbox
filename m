Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130746AbQLMVbO>; Wed, 13 Dec 2000 16:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131841AbQLMVbE>; Wed, 13 Dec 2000 16:31:04 -0500
Received: from front6m.grolier.fr ([195.36.216.56]:40357 "EHLO
	front6m.grolier.fr") by vger.kernel.org with ESMTP
	id <S130746AbQLMVax> convert rfc822-to-8bit; Wed, 13 Dec 2000 16:30:53 -0500
Date: Wed, 13 Dec 2000 21:00:01 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.LNX.4.10.10012131131090.19837-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012132035540.1275-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Linus Torvalds wrote:

> 
> 
> Ehh, I think I found it.
> 
> Hint: "ptep_mkdirty()".
> 
> Oops.
> 
> I'll bet you $5 USD (and these days, that's about a gadzillion Euros) that

Poor European Gérard as slim as 1.84 meter - 78 Kg these days.
What about old days poor European Linus versus these days American Linus
on these points ? ;-)

> this explains it.

Really ? :o)

> 		Linus

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
