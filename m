Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131071AbRBXBIl>; Fri, 23 Feb 2001 20:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131101AbRBXBIc>; Fri, 23 Feb 2001 20:08:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131071AbRBXBI0>; Fri, 23 Feb 2001 20:08:26 -0500
Subject: Re: [OPPS] 2.2.18 + Scheduling in interrupt
To: mistral@stev.org (James Stevenson)
Date: Sat, 24 Feb 2001 01:11:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0102240059240.1317-101000@cyrix.home> from "James Stevenson" at Feb 24, 2001 01:04:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WTFE-0007Uj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aiee, killing interrupt handler
> alloc_skb called nonatomically from interrupt c016468f
> eth0: Tx request while isr active.
> Scheduling in interrupt

What ethernet card was this ?
