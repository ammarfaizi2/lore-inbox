Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135595AbREHX7o>; Tue, 8 May 2001 19:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135596AbREHX7d>; Tue, 8 May 2001 19:59:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7349 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135595AbREHX7Y>;
	Tue, 8 May 2001 19:59:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.34887.893674.220288@pizda.ninka.net>
Date: Tue, 8 May 2001 16:59:03 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: macro@ds2.pg.gda.pl (Maciej W. Rozycki), linux-kernel@vger.kernel.org,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <E14xGS7-0000r5-00@the-village.bc.nu>
In-Reply-To: <15096.27432.381478.837650@pizda.ninka.net>
	<E14xGS7-0000r5-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > And just how is he going to test it ? Considering he was just
 > asking if the concept was reasonable I think you are a little out
 > of order

I can't test every platform when I have to make such changes.
But it always serves to show the port maintainer "what" the
change was.

Yes, I am slightly out of order if the intent is just "does
this idea look fine" (which it does btw, I can't  find any
problems with it).

I apologize to Maciej, but I do deplore him to actually do the
final bits for the other ports when he makes his final patch
submission.

Later,
David S. Miller
davem@redhat.com
