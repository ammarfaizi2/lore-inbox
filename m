Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTL3AtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTL3AtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:49:14 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:708 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264311AbTL3AtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:49:09 -0500
Date: Tue, 30 Dec 2003 01:49:07 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches
Message-ID: <20031230004907.GA29143@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030906125136.A9266@infomag.infomag.iguana.be> <20031229205246.A32604@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291209150.2113@home.osdl.org> <20031229212221.J30061@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291226400.2113@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312291226400.2113@home.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Linus Torvalds wrote:

> I do end up taking patches that have this syndrome if it looks like the 
> pain of not taking the messy revision history is larger than the pain of 
> just fixing it. Sometimes it's hard to avoid.
> 
> But most of the time the proper thing to do is to just not merge
> unnecessarily - if something is pending for a while, Bk does the merge
> correctly anyway, so you can just leave it pending and have me pull from
> an old tree (after you have verified in your own tree that the pull will 
> succeed and do the right thing).
> 
> That way it ends up being trivial to see where/when the changes happened.

Not being very used to BK, does that mean I have several trees around:

1. the official release tree
2. an "old tree" with my local change that I'm forwarding
3. a temporary test tree to see if the merge would succeed, which
   I'll get by cloning (1) and then pulling from (2)?

Well, talk about FAAAAAAST drives (10,025/min SCSI kind) unless you have
time to waste on all those BK consistency checks (which are, of course,
what #3 is all about).

Or am I missing some obvious short cut?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
