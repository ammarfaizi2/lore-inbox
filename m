Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281547AbRLAKCm>; Sat, 1 Dec 2001 05:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284041AbRLAKCW>; Sat, 1 Dec 2001 05:02:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284040AbRLAKCQ>; Sat, 1 Dec 2001 05:02:16 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: lm@bitmover.com (Larry McVoy)
Date: Sat, 1 Dec 2001 10:09:30 +0000 (GMT)
Cc: davidel@xmailserver.org (Davide Libenzi), lm@bitmover.com (Larry McVoy),
        akpm@zip.com.au (Andrew Morton),
        phillips@bonn-fries.net (Daniel Phillips),
        hps@intermeta.de (Henning Schmiedehausen),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <20011130171510.B19152@work.bitmover.com> from "Larry McVoy" at Nov 30, 2001 05:15:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A75O-0006hY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wasn't it you that were saying that Linux will never scale with more than
> > 2 CPUs ?
> 
> No, that wasn't me.  I said it shouldn't scale beyond 4 cpus.  I'd be pretty
> lame if I said it couldn't scale with more than 2.  Should != could.

Question: What happens when people stick 8 threads of execution on a die with
a single L2 cache ?


