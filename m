Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136020AbREBWYF>; Wed, 2 May 2001 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136022AbREBWXy>; Wed, 2 May 2001 18:23:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60690 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136020AbREBWXp>; Wed, 2 May 2001 18:23:45 -0400
Subject: Re: [OT] Interrupting select.
To: ptb@it.uc3m.es
Date: Wed, 2 May 2001 23:21:19 +0100 (BST)
Cc: lar@cs.york.ac.uk, linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <200105022156.f42LulT20491@oboe.it.uc3m.es> from "Peter T. Breuer" at May 02, 2001 11:56:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v4zq-0004Sy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What IS the magic combination that makes select interruptible
> by honest-to-goodness non-blocked signals!

man

[seriously man sigaction]

