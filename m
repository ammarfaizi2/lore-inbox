Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284813AbRLRTLe>; Tue, 18 Dec 2001 14:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284744AbRLRTJ4>; Tue, 18 Dec 2001 14:09:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38416 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284793AbRLRTIT>; Tue, 18 Dec 2001 14:08:19 -0500
Subject: Re: Scheduler ( was: Just a second ) ...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 18 Dec 2001 19:17:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0112180854070.2867-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 18, 2001 09:00:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GPkU-0008No-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The scheduler is eating 40-60% of the machine on real world 8 cpu workloads.
> > That isn't going to go away by sticking heads in sand.
> 
> Did you _read_ what I said?
> 
> We _have_ patches. You apparently have your own set.

I did read that mail - but somewhat later. Right now Im scanning l/k
every few days no more.

As to my stuff - everything I propose different to ibm/davide is about
cost/speed of ordering or minor optimisations. I don't plan to compete and
duplicate work
