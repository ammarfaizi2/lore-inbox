Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268443AbRG0Qy3>; Fri, 27 Jul 2001 12:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRG0QyT>; Fri, 27 Jul 2001 12:54:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48137 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268443AbRG0QyG>; Fri, 27 Jul 2001 12:54:06 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 27 Jul 2001 17:55:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        menion@srci.iwpsd.org (Joshua Schmidlkofer),
        linux-kernel@vger.kernel.org (kernel),
        god@namesys.com (Nikita Danilov), jeffm@suse.com (Jeff Mahoney)
In-Reply-To: <no.id> from "Hans Reiser" at Jul 27, 2001 08:41:53 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QAtQ-00062g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > Alan
> big endian support is resolved, there is a working patch for it by Jeff Mahoney, it passes all of
> our tests, but it is a feature not a bug fix, and not something for a supposedly stabilizing kernel.
> 
> Nikita, you were supposed to send the big endian support and some other stuff in to Alan for testing
> in the ac series, what is the status of patches that are supposed to be going to Alan?

I suspect its a bug fix to S/390, ppc and sparc users 8)

I'd be happy to test run it in -ac

