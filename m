Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbRL1SJV>; Fri, 28 Dec 2001 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286948AbRL1SJB>; Fri, 28 Dec 2001 13:09:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286959AbRL1SI7>; Fri, 28 Dec 2001 13:08:59 -0500
Subject: Re: State of the new config & build system
To: lm@bitmover.com (Larry McVoy)
Date: Fri, 28 Dec 2001 18:17:57 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lm@bitmover.com (Larry McVoy),
        kaos@ocs.com.au (Keith Owens), esr@thyrsus.com (Eric S. Raymond),
        davej@suse.de (Dave Jones), esr@snark.thyrsus.com (Eric S. Raymond),
        torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228094318.B3727@work.bitmover.com> from "Larry McVoy" at Dec 28, 2001 09:43:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K1Zt-0001JS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that if there is reusable code in BK, we're willing to let people use
> it under whatever license they want.  It would be nice if that actually
> happened after all the yelling and screaming.

mdbm is one I've not seen. The timings I've done are with db2/db3/tdb when
I was playing with a fast UDP server that had to do a db lookup per packet.

Alan
