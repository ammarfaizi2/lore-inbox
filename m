Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSEXWBA>; Fri, 24 May 2002 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSEXWBA>; Fri, 24 May 2002 18:01:00 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:23280 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312296AbSEXWA6>; Fri, 24 May 2002 18:00:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 24 May 2002 15:57:30 -0600
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020524215730.GF9997@turbolinux.com>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
	Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
	Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0204292127480.1709-100000@localhost.localdomain> <3CEDF94C.592636A6@kegel.com> <3CEDFCED.D10CD618@zip.com.au> <3CEE806D.D52FBEA5@kegel.com> <20020524202658.GI15703@dualathlon.random> <3CEEAE3D.EB64A3AA@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2002  17:18 -0400, Karim Yaghmour wrote:
> Just wanting to put the record straight here about the rtlinux patent.

IANAL or an embedded software expert, but...

> I've been involved in fighting this patent for the last 2 years. During
> this time, I have met and talked with many people about this issue. Today,
> I can assure you that the rtlinux patent is definitely a show-stopper for
> Linux.
> 
> It is no wonder that the established embedded vendors (WindRiver, QNX,
> etc.) feel no threat from Linux. They know that every time Linux will
> be evaluated, it will be put aside because of the patent.

What, so there are _no_ patents or other restrictions on any of the
commercial embedded OS vendor products?  I would imagine that you need
to pay some sort of license fee to those vendors in order to use their
code for products you sell.

I imagine that the rtlinux patent is also available for license, and
will only have a small per-usage fee <= other commercial license fees.
If not then the patent holder is foolish and there is no point in having
the patent in the first place.

Cheers, Andreas

PS - I'm not in favour of patents for Linux at all, but saying "you
     can't use rtlinux because of the patent" doesn't make sense.

PPS- I also think "defensive patents" on Linux are also a bad idea,
     because (a) the Linux source code is surely "published" and any
     ideas therein already constitute prior art for the sake of
     defending a patent infringement suit, and (b) since patents can
     be bought and sold any "defensive patents" might fall into the
     wrong hands if the patent holder goes bankrupt and the assets are
     sold off to the highest bidder - bad news for the entire Linux
     community.
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

