Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290574AbSARBTt>; Thu, 17 Jan 2002 20:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290575AbSARBTi>; Thu, 17 Jan 2002 20:19:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290574AbSARBT3>; Thu, 17 Jan 2002 20:19:29 -0500
Subject: Re: [STATUS 2.5]  January 17, 2001
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 18 Jan 2002 00:38:11 +0000 (GMT)
Cc: jdomingo@internautas.org (Jose Luis Domingo Lopez),
        boissiere@mediaone.net (Guillaume Boissiere),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C474E84.5000209@namesys.com> from "Hans Reiser" at Jan 18, 2002 01:21:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RN2p-0005VC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you heard anything about when Linus intends to code freeze?  In my 
> planning I am assuming Sept. 30 is way earlier than 2.6 would ship.  I 
> remember how long 2.4 took, and I simply assume 2.6 will be the same. 
>  At any rate, there is no way we'll be done earlier than September: it 
> is a deep rewrite.  Code looks so much better than the old code...., but 
> it is completely new code.

If Linus says september freezes in september and ships for christmas I will
be most suprised. If he says september freezes the may after and ships the
december after that I'd count it normal 

Personally I'd really like to see the block I/O stuff straightened out. The
neccessary VM bits done, device driver updates and a September freeze. I
think it can be done, and I think the resulting kernel will be way way
better for people with 1Gb+ of RAM, so much better that its worth making a
clear release at that point.

Alan
