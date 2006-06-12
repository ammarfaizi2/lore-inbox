Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWFLLXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWFLLXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWFLLXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:23:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:25579 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751880AbWFLLW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:22:59 -0400
X-Authenticated: #428038
Date: Mon, 12 Jun 2006 13:22:54 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Neil Brown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bernd Petrovitsch <bernd@firmix.at>,
       Matti Aarnio <matti.aarnio@zmailer.org>, jdow <jdow@earthlink.net>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060612112254.GC27069@merlin.emma.line.org>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bernd Petrovitsch <bernd@firmix.at>,
	Matti Aarnio <matti.aarnio@zmailer.org>, jdow <jdow@earthlink.net>,
	davids@webmaster.com, linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com> <193701c68d16$54cac690$0225a8c0@Wednesday> <1150100286.26402.13.camel@tara.firmix.at> <1150106004.22124.155.camel@localhost.localdomain> <17549.18674.809648.549618@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17549.18674.809648.549618@cse.unsw.edu.au>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown schrieb am 2006-06-12:

> On Monday June 12, alan@lxorguk.ukuu.org.uk wrote:
> > 
> > SPF *would* be wonderful if the users controlled SPF handling and
> > someone fixed the forwarding flaws in it, but neither is the case today.
> > 
> 
> The "forwarding flaws" are not flaws in SPF but in SMTP practice.

No. SPF neglected existing SMTP practice when it was invented, the
typical sign of something engineered without respect for realities. It
has since been given a crutch named SRS, but it still can't walk. And
rather than fixing the SPF/SRS/... problems, their disciples advocate it
and tell all the world it needs to change.

Quite overstating their own importance I'd say.

> I suspect they grew out of the multi-hop days of UUCP and similar
> protocols, but it isn't appropriate in todays Internet.

Your suspicions are irrelevant, and thanks goodness neither Wong nor
Brown nor Matthias Anree are the absolute rulers of the internet.

> A forwarded email is a new message and shouldn't claim to be from the
> original sender.

A forwarded email conveys the same message as the originator sent,
it's a long way from being a new message. The time of monks copying
books is long past.

> Forwarding systems *Shouldn't* simply forward the mail.

I am controlling the forwarding system, and you aren't going to take it
away from me.

> Yes, people have to change their forwarding practices to be fully SPF
> compliant, but that is a case of it is broke, and should be fixed
> anyway.

Right, <twisting your words> SPF should be fixed.

-- 
Matthias Andree
