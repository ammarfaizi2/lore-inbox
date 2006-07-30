Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWG3X0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWG3X0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWG3X0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:26:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42688 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932468AbWG3X0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:26:05 -0400
Subject: Re: ipw3945 status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Rene Rebe <rene@exactcode.de>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <1154293333.13635.43.camel@localhost>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <200607301937.15414.rene@exactcode.de>
	 <1154282618.13635.41.camel@localhost>
	 <200607302209.09735.rene@exactcode.de>
	 <1154293333.13635.43.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 00:44:23 +0100
Message-Id: <1154303063.2318.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-30 am 23:02 +0200, ysgrifennodd Kasper Sandberg:
> or perhaps people should just not install/use stuff illegal in their
> country.

Most users really don't understand the issues around wireless and
country specific rules. Some wireless implementations also don't deal
with moving between countries live (as happens all the time today in
Europe).

That means as a distribution vendor its really important to ship people
something that by default does the right thing and the legal thing here.
If people want to recompile kernels or hack firmware thats their
business, but out of the box it should behave.

