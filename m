Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276940AbRJHPaf>; Mon, 8 Oct 2001 11:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276946AbRJHPa0>; Mon, 8 Oct 2001 11:30:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276940AbRJHPaP>; Mon, 8 Oct 2001 11:30:15 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 8 Oct 2001 16:35:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), mingo@elte.hu (Ingo Molnar),
        hadi@cyberus.ca (jamal), linux-kernel@vger.kernel.org (Linux-Kernel),
        netdev@oss.sgi.com, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20011008172450.A726@athlon.random> from "Andrea Arcangeli" at Oct 08, 2001 05:24:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qcRa-0000uS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another thing I said recently is that the hardirq airbag have nothing to
> do with softirqs, and that's right. Patch messing the softirq logic in
> function of the hardirq airbag are just totally broken or at least
> confusing because incidentally merged together by mistake.

Agreed
