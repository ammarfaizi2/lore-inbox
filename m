Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316421AbSEQQ6M>; Fri, 17 May 2002 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSEQQ6L>; Fri, 17 May 2002 12:58:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30221 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316421AbSEQQ6L>; Fri, 17 May 2002 12:58:11 -0400
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 17 May 2002 18:17:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        paul@engsoc.org (Paul Faure), linux-kernel@vger.kernel.org
In-Reply-To: <20020517151755.GH11512@dualathlon.random> from "Andrea Arcangeli" at May 17, 2002 05:17:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178lM7-0006uZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hmm, tiny != burst. of course sometime ksoftirqd will kick in when it
> notices a burst. But it is irrelevant to this thread about SCHED_FIFO +
> ksoftirqd.

Agreed

> If there's SCHED_FIFO app in loop, ksoftirqd never runs and we only rely
> on the support from irq that we had in 2.4.0 and previous too.

Yes

