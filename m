Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUH3JOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUH3JOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUH3JOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:14:49 -0400
Received: from jib.isi.edu ([128.9.128.193]:28811 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S267515AbUH3JOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:14:44 -0400
Date: Mon, 30 Aug 2004 02:14:13 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>, Kenneth Lavrsen <kenneth@lavrsen.dk>,
       Jesper Juhl <juhl-lkml@dif.dk>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Summarizing the PWC driver questions/answers
Message-ID: <20040830091413.GA32665@isi.edu>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk> <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost> <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk> <200408280113.27530.oliver@neukum.org> <1093786799.27934.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093786799.27934.28.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.29, Alan Cox wrote:
> A license was granted, for ever.

	This has been discussed before (on this list, I think), and
the answer may surprise you, or maybe not:  nothing lasts forever.

	I am not a laywer.  I haven't looked at the U.K. copyright
laws.  I *have* read throught the relevant U.S. laws (a few years
back), and a copyright assignment or license (which I believe is a
broad enough category to include the GPL) *can* be terminated in the
U.S. in certain cases -- that's quite clear.  The "recapture" period
(for works created after 1978) is a five-year period that starts 35
years after the license was issued.  In that window, the author of
copyrighted code, or the author's heirs or estate, have the option to
revoke the original copyright assignment or license, i.e., in our
case, presumably, revoke the GPL.

	There are various details and procedures involved.  They must
be followed precisely, or the opportunity to recapture the copyright
may be lost.  One important detail is that work-for-hire copyright
assignments may not be recaptured.

	So, If you keep track of everyone to whom you, the author,
*directly* distribute a copy of your GPL'd work (and thus assign an
"original" GPL'd license), you might be able to effect a recapture by
notifying everyone on that list.  Then again, you might have to notify
everyone who ever received a copy of the GPL'd code, directly from you
or not.  The GPL raises certain issues that simply weren't forseen by
the framers of the statutes in question! :-)

	Again, I don't have the U.S. Federal Code references at hand.
However, here is an article that explains this issue for composers of
music:

http://www.ascap.com/estates/estatescopyrights.html

	Finally, three preemptive comments:

1)	This aspect of copyright law is something that all professional
	authors should know about.  You shouldn't have to relay upon
	a lawyer to know your basic legal rights.

2)	Linus Torvalds has recently reinforced the notion that the Linux
	developers comminuty should behave as honorable gentlebeings, rather
	than behave as lawyers.  This posting is not meant to gainsay that
	statement in any way.  Think of knowledge of copyright law as akin to
	knowing the terrain of a potential battlefield -- even though the
	successful strategist seeks victory without the need for battle
	(Sun Tzu, more or less).

3)	The U.S. Congress or courts could make further changes to the laws that
	affect copyright recapture.  Again, nothing is forever.

					Craig Milo Rogers
