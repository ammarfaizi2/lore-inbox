Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWFLJsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWFLJsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFLJsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:48:00 -0400
Received: from ns1.suse.de ([195.135.220.2]:63911 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751379AbWFLJsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:48:00 -0400
From: Neil Brown <neilb@suse.de>
To: "jdow" <jdow@earthlink.net>
Date: Mon, 12 Jun 2006 19:47:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17549.14402.71021.274336@cse.unsw.edu.au>
Cc: "Bernd Petrovitsch" <bernd@firmix.at>, <davids@webmaster.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
In-Reply-To: message from jdow on Monday June 12
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	<193701c68d16$54cac690$0225a8c0@Wednesday>
	<1150100286.26402.13.camel@tara.firmix.at>
	<00de01c68df9$7d2b2330$0225a8c0@Wednesday>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 12, jdow@earthlink.net wrote:
> 
> And just recently we received a spate of spam that came from a domain
> that disappeared almost immediately. Domain names are cheap. They can
> vouch for the spam run. Then what happens to them doesn't matter. But
> the SPF record passes.
> 

So the obvious next step (Which I remember being discussed on the SPF
mailing list shortly before I had to unsubscribe) is to develop a
mechanism to measure the credibility of new domains.  No point doing
this until authenticity is fairly reliable, but once it is, that will
be the next logical step.

> {^_-}   There Ain't No Such Thing As A Free Lunch.
>         Too many people think SPF is a free lunch.

Can't argue with that - both points are very true.

NeilBrown
