Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264051AbRFERUR>; Tue, 5 Jun 2001 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264052AbRFERUH>; Tue, 5 Jun 2001 13:20:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264051AbRFERT6>; Tue, 5 Jun 2001 13:19:58 -0400
Subject: Re: Missing cache flush.
To: kira@linuxgrrls.org (kira brown)
Date: Tue, 5 Jun 2001 18:16:33 +0100 (BST)
Cc: dwmw2@infradead.org (David Woodhouse), davem@redhat.com (David S. Miller),
        cw@f00f.org (Chris Wedgwood), jgarzik@mandrakesoft.com (Jeff Garzik),
        bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
In-Reply-To: <Pine.LNX.4.30.0106051028390.10786-100000@carrot.linuxgrrls.org> from "kira brown" at Jun 05, 2001 10:29:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157KRV-00076q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. Buggy implementations like the Cyrix 486es that don't properly maintain
>    cache coherency.

The early Cyrix CPUs (and some 1.x rev 6x86 cpus I believe too) arent supported
and dont work. The problem is best corrected with a hammer and a visit to
ebay

