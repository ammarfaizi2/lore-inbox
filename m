Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283680AbRK3P2e>; Fri, 30 Nov 2001 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283681AbRK3P2Y>; Fri, 30 Nov 2001 10:28:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283680AbRK3P2R>; Fri, 30 Nov 2001 10:28:17 -0500
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the problem!
To: jessica@twu.net (Jessica Blank)
Date: Fri, 30 Nov 2001 15:36:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111300834270.3351-100000@twu.net> from "Jessica Blank" at Nov 30, 2001 08:35:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169piJ-0003qJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.sun.com/sun-on-net/performance/tcp.slowstart.html

This URL has no bearing or relation to the things you seem to be
reporting. There are hundreds of possible and more likely reason (load
on that ethernet segment, half/full duplex, 10/100Mbit settings) or even
incorrect irq configuration that are rather more plausible

It can also be highly card dependant how a box behaves on an overloaded lan
