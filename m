Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWFLKdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWFLKdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWFLKdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:33:20 -0400
Received: from ns.suse.de ([195.135.220.2]:1712 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751826AbWFLKdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:33:20 -0400
From: Neil Brown <neilb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 12 Jun 2006 20:33:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17549.17128.4155.144140@cse.unsw.edu.au>
Cc: jdow <jdow@earthlink.net>, Bernd Petrovitsch <bernd@firmix.at>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
In-Reply-To: message from Alan Cox on Monday June 12
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	<193701c68d16$54cac690$0225a8c0@Wednesday>
	<1150100286.26402.13.camel@tara.firmix.at>
	<00de01c68df9$7d2b2330$0225a8c0@Wednesday>
	<17549.14402.71021.274336@cse.unsw.edu.au>
	<1150108220.22124.164.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 12, alan@lxorguk.ukuu.org.uk wrote:
> Ar Llu, 2006-06-12 am 19:47 +1000, ysgrifennodd Neil Brown:
> > mailing list shortly before I had to unsubscribe) is to develop a
> > mechanism to measure the credibility of new domains.  No point doing
> > this until authenticity is fairly reliable, but once it is, that will
> > be the next logical step.
> 
> Which is very very hard.

We do hard things every day, don't we? 

> 
> Think about it logically. Today to get a domain you need a credit/debit
> card. A credit/debit card is ID managed by organisations very keen that
> they don't get copied or faked. You are talking about building a
> worldwide system that is more effective than the ones the banks run: for
> a ten US dollar (ie peanuts and falling) value domain.

Thinks about it creatively.
How many domains need to be able to send mail?  I suspect a tiny
fraction.
Having a domain that can be a web address and a destination for mail
is (I suspect) the greatest demand.  Having a domain that can send
mail it less important to many, but important enough to some that they
will pay.

Yes, it is hard, but if everyone says "that cannot work" we will never
move forward.  SPF may not be a big step forward, but I believe it is
a step forward (and at least it is a step!)

NeilBrown
