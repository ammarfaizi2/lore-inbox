Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268568AbRGYNaB>; Wed, 25 Jul 2001 09:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268569AbRGYN3w>; Wed, 25 Jul 2001 09:29:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31250 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268568AbRGYN3h>; Wed, 25 Jul 2001 09:29:37 -0400
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
To: adam-dated-996283107.318d97@flounder.net (Adam McKenna)
Date: Wed, 25 Jul 2001 14:30:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010724182512.B4614@flounder.net> from "Adam McKenna" at Jul 24, 2001 06:25:12 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15POk0-00020K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> >From what I've been able to find on Google, there are several other people
> with this problem;  Has anyone come up with a solution?  I have ServerWorks
> OSB4 support compiled into the kernel, but this happens with or without it.

The OSB4 support in Linus 2.4 tree is out of date. The chances are that is
not the cause of the DMA timeout - but do try the 2.4.6-ac5 tree

And no there is no 2.4.6-ac5-xfs tree I know of, if you need that you'll
have to merge stuff
