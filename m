Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264029AbRFHQEy>; Fri, 8 Jun 2001 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264120AbRFHQEo>; Fri, 8 Jun 2001 12:04:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22544 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264029AbRFHQEk>; Fri, 8 Jun 2001 12:04:40 -0400
Subject: Re: Earyly Cyrix CPUs was Re: Missing cache flush.
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 8 Jun 2001 17:00:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kira@linuxgrrls.org (kira brown),
        dwmw2@infradead.org (David Woodhouse),
        davem@redhat.com (David S. Miller), cw@f00f.org (Chris Wedgwood),
        jgarzik@mandrakesoft.com (Jeff Garzik), bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20010606194434.A38@toy.ucw.cz> from "Pavel Machek" at Jun 06, 2001 07:44:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158OgN-0002pI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is list of cpu's not supported? I want one ;-).
> [It is even more broken than 386? Wow!]

Some of the early Cyrix cpus get cache corruption. I dont know of any work
around. These are the CPU's that won't run some versions of gcc (optimised
egcs 1.1.2 segfaulted at random non optimised worked, both work on other
cpus)


