Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbRENXxH>; Mon, 14 May 2001 19:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbRENXw5>; Mon, 14 May 2001 19:52:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10252 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262584AbRENXwh>; Mon, 14 May 2001 19:52:37 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: jan@gondor.com (Jan Niehusmann)
Date: Tue, 15 May 2001 00:48:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@transmeta.com (H. Peter Anvin),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu
In-Reply-To: <20010515014357.A7928@gondor.com> from "Jan Niehusmann" at May 15, 2001 01:43:57 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zS4y-0001lP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why can't we configure this in user space? I think of something like
> /etc/major-numbers. We could then tell the kernel at module load time what
> major number to use for a given driver.

We've got one of those lists. H Peter Anvin maintains it.

Don't get me wrong - if in 2.5.x someone can produce a scheme which works and
works well I'll be more than happy to be proved wrong, and Im sure hpa will
be glad his registrar role now becomes default device naming not numbers
and I suspect moves into the FHS/LSB. After all numbering or not most
vendors will want to ship a common device naming scheme, at least unless
they have fundamental reasons why not to (eg a desire to use arabic names)

Alan

