Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278813AbRKHXWq>; Thu, 8 Nov 2001 18:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278829AbRKHXWg>; Thu, 8 Nov 2001 18:22:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7428 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278813AbRKHXWY>; Thu, 8 Nov 2001 18:22:24 -0500
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
To: defiler@null.net (Wilson)
Date: Thu, 8 Nov 2001 23:29:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001b01c1689f$fdd77850$c800000a@Artifact> from "Wilson" at Nov 08, 2001 04:54:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161ycB-00016t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Or are we talking about Athlon-optimizations bugs ? Or about Athlon SMP ?
> 
> Bugs in the Athlon optimizations present in the Linux kernel.

The only bugs we've seen recently appear to be in Athlon chipsets and/or
BIOS  setup. 2.4.14 should sort those by poking around and doing what the
BIOS didn't
