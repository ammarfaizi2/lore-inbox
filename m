Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWGaHMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGaHMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGaHMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:12:10 -0400
Received: from mx01.qsc.de ([213.148.129.14]:13740 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932508AbWGaHMI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:12:08 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: ipw3945 status
Date: Mon, 31 Jul 2006 09:11:18 +0200
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <1154303063.2318.12.camel@localhost.localdomain> <1154305176.13635.45.camel@localhost>
In-Reply-To: <1154305176.13635.45.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607310911.18584.rene@exactcode.de>
X-Spam-Score: -101.4 (---------------------------------------------------)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Monday 31 July 2006 02:19, Kasper Sandberg wrote:
	> On Mon, 2006-07-31 at 00:44 +0100, Alan Cox wrote: > > Ar Sul,
	2006-07-30 am 23:02 +0200, ysgrifennodd Kasper Sandberg: > > > or
	perhaps people should just not install/use stuff illegal in their > > >
	country. > > > > Most users really don't understand the issues around
	wireless and > > country specific rules. Some wireless implementations
	also don't deal > > with moving between countries live (as happens all
	the time today in > > Europe). > > > > That means as a distribution
	vendor its really important to ship people > > something that by default
	does the right thing and the legal thing here. > > If people want to
	recompile kernels or hack firmware thats their > > business, but out of
	the box it should behave. > as it will never do properly requiring a
	binary daemon, distributions > are having a hard enough time to try and
	redistribute those firmwares > where its legal, some even wont, but a
	userspace daemon is out of the > question for most. [...] 
	Content analysis details:   (-101.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 31 July 2006 02:19, Kasper Sandberg wrote:
> On Mon, 2006-07-31 at 00:44 +0100, Alan Cox wrote:
> > Ar Sul, 2006-07-30 am 23:02 +0200, ysgrifennodd Kasper Sandberg:
> > > or perhaps people should just not install/use stuff illegal in their
> > > country.
> > 
> > Most users really don't understand the issues around wireless and
> > country specific rules. Some wireless implementations also don't deal
> > with moving between countries live (as happens all the time today in
> > Europe).
> > 
> > That means as a distribution vendor its really important to ship people
> > something that by default does the right thing and the legal thing here.
> > If people want to recompile kernels or hack firmware thats their
> > business, but out of the box it should behave.
> as it will never do properly requiring a binary daemon, distributions
> are having a hard enough time to try and redistribute those firmwares
> where its legal, some even wont, but a userspace daemon is out of the
> question for most.

Sure not. That is why I wanted to direct the discussion in what country
enforcing scheme we should go.

-- 
  René Rebe - ExactCODE - Berlin (Europe / Germany)
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
