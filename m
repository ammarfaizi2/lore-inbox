Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbUB2Jc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 04:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUB2Jc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 04:32:26 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:20957 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S262023AbUB2JcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 04:32:24 -0500
Subject: Re: Worrisome IDE PIO transfers...
From: Aubin LaBrosse <arl8778@rit.edu>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402290408.12917.bzolnier@elka.pw.edu.pl>
References: <4041232C.7030305@pobox.com> <20040229015041.GQ3883@waste.org>
	 <40415152.8040205@pobox.com>  <200402290408.12917.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1078047142.5232.41.camel@rain.rh.rit.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 04:32:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 22:08, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 29 of February 2004 03:41, Jeff Garzik wrote:
> > Matt Mackall wrote:
> > > On Sun, Feb 29, 2004 at 01:21:30AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > >>I like Alan's idea to use loopback instead of "bswap".
> > >
> > > Or, more likely, device mapper.
> >
> > Somehow I doubt anybody cares enough to write a whole driver just for
> > this unlikely case.
> 
> Any TiVo hacker reading this? :)
> 

ahem.  now for the whole list instead of just Bart, (sorry Bart) in case
any of you gurus have insights for me (even if it's just to tell me I'm
biting off more than I can chew.)

I'm definitely reading, but not necessarily comprehending.  I upgraded a
60GB TiVo to 2x80GB in about 2002 using 2.4 and some userland tools.  in
fact i was just contemplating doing another upgrade since the 80s in it
now are on their way out i think, so i'll even have some spare TiVo
drives to fool around with during the development of this thing. I'm
probably not qualified to begin an undertaking like this, I'm just a
student, but....I've always wanted to be a kernel hacker. ;-) but i'm
not sure I understand what would be involved. And, does this mean I'll
have to use 2.4 to do my next upcoming drive replacement? (replacing the
drives in the tivo requires a host linux box on which to do it)

If someone would be kind enough to give me a little more info about the
dm driver for tivo drives, i'd at least entertain the idea...

-Aubin


