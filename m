Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbRFHP6z>; Fri, 8 Jun 2001 11:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264029AbRFHP6o>; Fri, 8 Jun 2001 11:58:44 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S264026AbRFHP6g>;
	Fri, 8 Jun 2001 11:58:36 -0400
Date: Wed, 6 Jun 2001 19:44:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kira brown <kira@linuxgrrls.org>, David Woodhouse <dwmw2@infradead.org>,
        "David S. Miller" <davem@redhat.com>, Chris Wedgwood <cw@f00f.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Earyly Cyrix CPUs was Re: Missing cache flush.
Message-ID: <20010606194434.A38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0106051028390.10786-100000@carrot.linuxgrrls.org> <E157KRV-00076q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E157KRV-00076q-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 05, 2001 at 06:16:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi1

> > 3. Buggy implementations like the Cyrix 486es that don't properly maintain
> >    cache coherency.
> 
> The early Cyrix CPUs (and some 1.x rev 6x86 cpus I believe too) arent supported
> and dont work. The problem is best corrected with a hammer and a visit to
> ebay

What is list of cpu's not supported? I want one ;-).

[It is even more broken than 386? Wow!]

[Is it really not work-aroundable? LIke declaring no DMA on system and using
PIO for floppy?]
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

