Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131146AbRCJTfq>; Sat, 10 Mar 2001 14:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131147AbRCJTfg>; Sat, 10 Mar 2001 14:35:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131146AbRCJTfY>; Sat, 10 Mar 2001 14:35:24 -0500
Subject: Re: Kernel 2.4.1 on RHL 6.2
To: jjs@mirai.cx (J Sloan)
Date: Sat, 10 Mar 2001 19:37:45 +0000 (GMT)
Cc: miquels@cistron-office.nl (Miquel van Smoorenburg),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3AAA7D5F.A16AA1C7@mirai.cx> from "J Sloan" at Mar 10, 2001 11:15:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bpBU-0007GH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> He probably removed the original kernel-devel package,
> which contained the links above, so they would have to
> be remade.

Linking them to /usr/src and thus people linking them to current kernel sources
while basically harmless is indeed not the preferred approach. So he's right
that older RH should have put the headers for the kernel that match glibc into
/usr/include directly

