Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSEXXNS>; Fri, 24 May 2002 19:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSEXXNR>; Fri, 24 May 2002 19:13:17 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:30960 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312681AbSEXXNR>; Fri, 24 May 2002 19:13:17 -0400
Date: Fri, 24 May 2002 17:09:37 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Karim Yaghmour <karim@opersys.com>, Dan Kegel <dank@kegel.com>,
        Hugh Dickins <hugh@veritas.com>, Christoph Rohland <cr@sap.com>,
        Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020524230937.GH9997@turbolinux.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Karim Yaghmour <karim@opersys.com>, Dan Kegel <dank@kegel.com>,
	Hugh Dickins <hugh@veritas.com>, Christoph Rohland <cr@sap.com>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020524215730.GF9997@turbolinux.com> <E17BNgS-0007UA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2002  23:37 +0100, Alan Cox wrote:
> > What, so there are _no_ patents or other restrictions on any of then
> > commercial embedded OS vendor products?
> 
> Thousands of them. Some of them like the Siemens power management patent
> really hurt Linux too.

Yes, that was my (weak) attempt at sarcasm.

> > PPS- I also think "defensive patents" on Linux are also a bad idea,
> >      because (a) the Linux source code is surely "published" and any
> >      ideas therein already constitute prior art for the sake of
> >      defending a patent infringement suit, and (b) since patents can
> >      be bought and sold any "defensive patents" might fall into the
> >      wrong hands if the patent holder goes bankrupt and the assets are
> >      sold off to the highest bidder - bad news for the entire Linux
> >      community.
> 
> Those defensive patents also provide scope for trading stuff with other
> companies, and finally never forget that if you own patents and say its
> a stupid idea you carry a *lot* more weight.

Well, the problem I try to highlight here is as follows (for example):
a)
   - FSMlabs goes out of business
   - they owe money to creditors
   - creditors see patent as an asset to be sold to recoup some money
   - nasty company buys patent rights
b)
   - nasty company has lots of money, buys FSMlabs outright
- nasty company does not license patent for free to GPL software users

Now, like I said, IANAL, but it may be that the _license_agreement_
which allows one to use the patent is between FSMlabs and GPL software
users.  If the patent is transferred to the nasty company, wouldn't that
make the original license agreement = (void *)NULL?  The nasty company
may be under no obligation to have favourable (=free) license terms for
the patent.

If I tell someone "you can sleep in my basement for free" and then I
sell my house, I doubt the new house owners are under any obligation
to let that person stay in their basement for free, or at all.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

