Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276597AbRI2T1r>; Sat, 29 Sep 2001 15:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276596AbRI2T1i>; Sat, 29 Sep 2001 15:27:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276598AbRI2T1Z>; Sat, 29 Sep 2001 15:27:25 -0400
Subject: Re: 2.4.9-ac10 IDE access slows as uptime increases
To: saxm@dcs.ed.ac.uk (Steve Maughan)
Date: Sat, 29 Sep 2001 20:31:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        tmwg-linuxknl@inxservices.com (George Garvey),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010929202752.A25602@ummagumma> from "Steve Maughan" at Sep 29, 2001 08:27:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nPpx-0002n2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have what sounds like a similar problem - assuming it is a problem
> with the IDE layer dropping the speed - except mine is with my CD or
> DVD drive. They run a lot slower under the 2.4.x kernels than under
> 2.2.19 (looking at 2-3megs/s under 2.4.x, 5-7megs/s under 2.2.19).
> 
> Also when using 2.4.x, the kernel has a habit of disabling DMA and
> performance plummets. Yet it is fine with 2.2.19.
> 
> Is this a related issue? Is there a fix for this?

That sounds different, Talk to Andre I guess
