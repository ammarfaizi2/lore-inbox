Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKEW6l>; Sun, 5 Nov 2000 17:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKEW6b>; Sun, 5 Nov 2000 17:58:31 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:2929 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129117AbQKEW6U>;
	Sun, 5 Nov 2000 17:58:20 -0500
Message-ID: <3A05E4B7.8C3D261C@Rikers.org>
Date: Sun, 05 Nov 2000 15:52:39 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9vaio i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <E13sYXM-0005fR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Perhaps I did not explain myself, or perhaps I misunderstand your
> > comments. I was responding to a comment that we could just copy some of
> > the optimizations from Pro64 over into gcc. Whether Pro64 understands
> > gcc syntax is immaterial to this question is it not?
> 
> If gcc is architecturally unable to do ia64 well, pro64 is free software and
> both understand the same syntax Im at a bit of a loss why that is productive 

Alan Cox wrote in another message:
> Or a third party decides its a silly situation and does it anyway

A definite possibility.
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
