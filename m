Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272451AbRIYSo2>; Tue, 25 Sep 2001 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272404AbRIYSoS>; Tue, 25 Sep 2001 14:44:18 -0400
Received: from [195.223.140.107] ([195.223.140.107]:41454 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S271924AbRIYSoL>;
	Tue, 25 Sep 2001 14:44:11 -0400
Date: Tue, 25 Sep 2001 20:44:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: john slee <indigoid@higherplane.net>
Cc: arjan@fenrus.demon.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
Message-ID: <20010925204428.A8350@athlon.random>
In-Reply-To: <E15lH4e-0000VP-00@the-village.bc.nu> <m15lH5A-000OVWC@amadeus.home.nl> <20010925183357.E29541@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925183357.E29541@higherplane.net>; from indigoid@higherplane.net on Tue, Sep 25, 2001 at 06:33:57PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 06:33:57PM +1000, john slee wrote:
> On Sun, Sep 23, 2001 at 10:46:36PM +0100, arjan@fenrus.demon.nl wrote:
> > In article <E15lH4e-0000VP-00@the-village.bc.nu> you wrote:
> > >> If you took my patch for it, PLEASE don't send it for inclusion; it's an
> > >> evil hack and no longer needed when Intel fixes the bug in their 440GX bios.
> > 
> > > "when" is not a word I find useful about most bios bugs. Try "if" or
> > > "less likely that being hit on the head by an asteroid"
> > 
> > This case is different. Intel promised the update "soon". For them it's
> 
> oh, they _promised_!  great!
> 
> on another note...
> 
> 2.4.10 is great incidentally, noticeably improved performance for
> a somewhat large postgresql db on raid0 (35GB, ~100 million rows)

This was actually the first priority and it's nice to hear it is
apparently been achieved successfully.

I also take the opportunity to remind everybody to keep the
00_vm-tweaks-1 from 2.4.10aa1 applied on top of 2.4.10, it seems quite
important here.

thanks,
Andrea
