Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRKHM0I>; Thu, 8 Nov 2001 07:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRKHMZz>; Thu, 8 Nov 2001 07:25:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61452 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276894AbRKHMZP>; Thu, 8 Nov 2001 07:25:15 -0500
Subject: Re: SYN cookies security bugfix?
To: bryanxms@ecst.csuchico.edu (B. James Phillippe)
Date: Thu, 8 Nov 2001 12:32:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.4.31.0111072116350.8925-100000@uranus.terran> from "B. James Phillippe" at Nov 07, 2001 09:20:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161oM3-0007Xm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I received a forwarded message from SuSE regarding a security vulnerability
> with respect to randomization of the ISN for SYN cookies - or something to
> that effect.  I have not been able to find the patch which addresses this
> problem; if anyone can point me towards it, I would be appreciative.

Its fixed in 2.2.20, you can grab the 2.2 patch from there
