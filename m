Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKHBih>; Tue, 7 Nov 2000 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbQKHBi0>; Tue, 7 Nov 2000 20:38:26 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51393 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S129245AbQKHBiU>;
	Tue, 7 Nov 2000 20:38:20 -0500
Date: Tue, 7 Nov 2000 17:38:09 -0800
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Dag Brattli <dagb@fast.no>
Subject: Re: [RANT] Linux-IrDA status
Message-ID: <20001107173809.A24129@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20001107171401.A24041@bougret.hpl.hp.com> <3A08AB56.10BD5007@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A08AB56.10BD5007@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Nov 07, 2000 at 08:24:38PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 08:24:38PM -0500, Jeff Garzik wrote:
> 
> Take a look at
> http://www.uwsg.iu.edu/hypermail/linux/kernel/9908.0/0669.html  This
> happened with ISDN.  Slightly different situation, but similar.

	I'm familiar with that. The *BIG* difference is that Dag has
always sent his patch to Linus from the very start, when it was still
small, whereas ISDN did stay on their patch from a long time.

> IMHO Dag should send break up his patches into small chunks, and feed
> those to Linus, with an explanation of each chunk.  That's what
> everybody else does... :)

	If you can break up stuff that has accumulated over one year,
please tell me so. Most of the original patches have been lost in the
mist of time. We could send it file by file, but that would give some
interesting results ;-)
	There is also a tradeoff between having the maintainer doing
the filtering to make sure that what's get checked in is safe and
getting junk in the kernel. With IrDA, Dag make sure to test and
integrate each patch before sending it to Linus, which of course make
bigger chunks. Also, some of the contribution on the IrDA mailing list
are big chunks of patches by themselves.
	Anyway, Linus should read the Linux-IrDA mailing list if he
really want to keep up with the gory details ;-)

> 	Jeff

	Ciao...

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
