Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRG0WKL>; Fri, 27 Jul 2001 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRG0WJv>; Fri, 27 Jul 2001 18:09:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8974 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261651AbRG0WJo>; Fri, 27 Jul 2001 18:09:44 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 27 Jul 2001 23:10:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), "pcg( Marc)"@goof.com (A. Lehmann),
        menion@srci.iwpsd.org (Joshua Schmidlkofer),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "Hans Reiser" at Jul 28, 2001 01:47:25 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QFoT-0006fY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> By the way, how about considering the use of tests before redhat coders put stuff in the linux
> kernel?  You know, if VFS changes actually got tested before users encountered things like Viro
> breaking ReiserFS in 2.4.5, it would be nice.
> At Namesys, like all normal software shops, we actually run a test suite before shipping code
> externally.  We usually try to require that it be tested by at least one person in addition to the
> code author.

*PLONK*

No doubt if Namesys ran test suites all the tail merging bug fiasco and the
directory/tree balance races wouldnt have happened.
