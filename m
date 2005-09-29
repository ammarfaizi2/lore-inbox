Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVI2Sj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVI2Sj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2Sj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:39:59 -0400
Received: from magic.adaptec.com ([216.52.22.17]:44749 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932342AbVI2Sj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:39:58 -0400
Message-ID: <433C34F0.4080307@adaptec.com>
Date: Thu, 29 Sep 2005 14:39:44 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>	 <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>	 <433BFB1F.2020808@adaptec.com> <1128007032.11443.77.camel@tara.firmix.at>	 <433C174D.4050302@adaptec.com> <1128014007.11443.108.camel@tara.firmix.at>
In-Reply-To: <1128014007.11443.108.camel@tara.firmix.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 18:39:53.0707 (UTC) FILETIME=[2EA6C3B0:01C5C525]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/05 13:13, Bernd Petrovitsch wrote:
> different opinions about "quality" and/or "correct vs wrong" - I can't
> decide since I have virtually no knowledge about SCSI core internals,

Ok.

> discussions on the Linux-SCSI-ML, etc. to decide - not even for me -,
> who is "right" and/or "wrong" in which aspect or in general), it comes
> down to "better the not-so-good design and working code than the best
> design and no code".

That sounds very fine, _but_ "the community" isn't a "corporation".

"The community" is by far and wide very close friends, so if you
point out to one of them that his code is wrong, even if all
other see that you're indeed correct, no one would say anything.

Why?  Because he doesn't want to same thing done to him.

So it doesn't matter who is right or who is wrong.  What matters
is who has political power to have it his way.

> So just copy the old core, throw out what you don't want, need and/or
> like and voila. If it *is* "better", it will succeed and people will
> come and help.

Blesses art thou, who believeth.

I wish it worked like this, I really wished.  Sadly its doesn'
work like this.

James is a strong political figure.  He keeps people who he thinks
know more than him at bay.  I can quote several names here, who
are active and some who were active at one point or another,
all very well versed in the T10 ways, but it wouldn't be fare to them.

So what you have is a strong political game: they don't care
what is right or wrong, they'll implement it the way _they_ think
is right, in effect alongside _their_ code.

I'm not sure how much History the readers have studied, but such
politics have always yielded to extinction.

The reason is _not_ because you reject something, but because
you end up always doing it always _your_ way.  Eventually you
become unfit to compete when the world has changed _so much_
around you, that "your way" is no longer relevant and the change
to make you fit is so radical, that it is impossible to do.

So you see, it is _not_ about accepting code, it is about
accepting _ideas_ and _innovation_.

James can still do everything _his_ way.  The question is
how many _years_ would this be relevant?

> [0]: Not in the ironic interpretation in German which translates roughly
>      to "great, another one does it".

Yes, but in "the community" people want "great, he does it _my_ way".

	Luben


