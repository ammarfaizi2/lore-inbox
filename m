Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWGaATv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWGaATv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWGaATv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:19:51 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:63875 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932482AbWGaATv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:19:51 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rene Rebe <rene@exactcode.de>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <1154303063.2318.12.camel@localhost.localdomain>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <200607301937.15414.rene@exactcode.de>
	 <1154282618.13635.41.camel@localhost>
	 <200607302209.09735.rene@exactcode.de>
	 <1154293333.13635.43.camel@localhost>
	 <1154303063.2318.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 02:19:36 +0200
Message-Id: <1154305176.13635.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 00:44 +0100, Alan Cox wrote:
> Ar Sul, 2006-07-30 am 23:02 +0200, ysgrifennodd Kasper Sandberg:
> > or perhaps people should just not install/use stuff illegal in their
> > country.
> 
> Most users really don't understand the issues around wireless and
> country specific rules. Some wireless implementations also don't deal
> with moving between countries live (as happens all the time today in
> Europe).
> 
> That means as a distribution vendor its really important to ship people
> something that by default does the right thing and the legal thing here.
> If people want to recompile kernels or hack firmware thats their
> business, but out of the box it should behave.
as it will never do properly requiring a binary daemon, distributions
are having a hard enough time to try and redistribute those firmwares
where its legal, some even wont, but a userspace daemon is out of the
question for most.
> 
> 

