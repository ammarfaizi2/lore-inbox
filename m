Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbRGENnE>; Thu, 5 Jul 2001 09:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbRGENmo>; Thu, 5 Jul 2001 09:42:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11528 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265174AbRGENmd>; Thu, 5 Jul 2001 09:42:33 -0400
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
To: rct@gherkin.sa.wlk.com (Bob_Tracy)
Date: Thu, 5 Jul 2001 14:42:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, dmircea@kappa.ro, linux-kernel@vger.kernel.org
In-Reply-To: <m15I81P-0005khC@gherkin.sa.wlk.com> from "Bob_Tracy" at Jul 05, 2001 07:14:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I9Oy-0002av-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something I forgot to mention that I didn't see in any of the other
> problem reports.  In my case, the panic happens immediately after
> "Calibrating delay loop" appears during the boot sequence.

Duplicated here. Works fine on a non Cyrix processor with the same kernel image.
Perhaps the folks who submitted the 2.4.6 tasklet changes could review them ?

