Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274243AbRJEWNm>; Fri, 5 Oct 2001 18:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274244AbRJEWNc>; Fri, 5 Oct 2001 18:13:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12555 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274243AbRJEWNS>; Fri, 5 Oct 2001 18:13:18 -0400
Subject: Re: Linux and 760MP
To: jussi.laako@kolumbus.fi (Jussi Laako)
Date: Fri, 5 Oct 2001 23:19:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BBE2183.2512D176@kolumbus.fi> from "Jussi Laako" at Oct 06, 2001 12:09:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pdJC-0007ow-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> > memory the production ones have a couple of IDE errata (performance and
> > can't enable prefetching) and an APIC one
> 
> Is there workaround for these in recent -ac kernels? So is it safe to buy
> Tyan Tiger MP for example?

Nothing should be needed. If it is then running "noapic" is going to cure
it.
