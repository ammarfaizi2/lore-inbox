Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSG2Atf>; Sun, 28 Jul 2002 20:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSG2Atf>; Sun, 28 Jul 2002 20:49:35 -0400
Received: from ns.suse.de ([213.95.15.193]:27909 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318040AbSG2Ate>;
	Sun, 28 Jul 2002 20:49:34 -0400
Date: Mon, 29 Jul 2002 02:52:54 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, axboe@suse.de, linux-kernel@vger.kernel.org,
       martin@dalecki.de
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729025254.F11918@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	axboe@suse.de, linux-kernel@vger.kernel.org, martin@dalecki.de
References: <UTC200207282359.g6SNxgW24418.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0207281725110.8208-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207281725110.8208-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Jul 28, 2002 at 05:33:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:33:25PM -0700, Linus Torvalds wrote:

 > Jens is actually documented as being the SCSI maintainer, but that is
 > probably because he is the block device maintainer and he ended up
 > maintaining the more fundamental changes. I've seen James Bottomley more
 > as the "change SCSI internals" guy, and Doug mentioned that he will have
 > more time to work on 2.5.x not that long ago, so I do think all three
 > consider themselves at least partial maintainers already.

*nods* Both Jens and Doug were invaluable at times when I bought forward a
bunch of stuff from 2.4, (and later scooped up various other small
SCSI bits from assorted places).  With a lack of much understanding
in this area, (and lack of motivation to dig too deeply -- I don't even
own any SCSI hard disks/controllers except for some ancient cpqarray thats
rarely powered on), pushing the various bits onto you with meaningful
comments attached became quite hard work, and at times, impossible
without further explanation from Jens or Doug.

Thankfully, Doug did an excellent job at weeding out the crap bits I had
merged, and pushing on the good tried-n-tested bits.

So they both get my vote. James I think is actually doing some of the
grunt work which means offloading the 'syncing/pushing to Linus' fun
onto one of the others is probably a good idea if they're not opposed to
doing it.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
