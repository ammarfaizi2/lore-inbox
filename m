Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284032AbRLAJkm>; Sat, 1 Dec 2001 04:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284033AbRLAJkc>; Sat, 1 Dec 2001 04:40:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47368 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284032AbRLAJkX>; Sat, 1 Dec 2001 04:40:23 -0500
Subject: Re: [PATCH] task_struct colouring ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sat, 1 Dec 2001 09:49:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml),
        yamamura@flab.fujitsu.co.jp (Shuji YAMAMURA)
In-Reply-To: <Pine.LNX.4.40.0111301614000.1600-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Nov 30, 2001 04:33:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A6lc-0006cV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The point is why store kernel pointers in global registers when You can
> achieve the same functionality, with a smaller patch, that does not need
> to be recoded for each CPU, without using global registers.

Because it is much much much faster

Alan
