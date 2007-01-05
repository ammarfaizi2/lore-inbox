Return-Path: <linux-kernel-owner+w=401wt.eu-S1161109AbXAEO0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbXAEO0L (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbXAEO0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:26:11 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:41446 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161111AbXAEO0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:26:10 -0500
Date: Fri, 5 Jan 2007 09:26:08 -0500
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: wireless Q
Message-ID: <20070105142608.GA17269@csclub.uwaterloo.ca>
References: <200701040051.51930.gene.heskett@verizon.net> <20070104221418.GA5684@tuxdriver.com> <200701042148.36521.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701042148.36521.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 09:48:36PM -0500, Gene Heskett wrote:
> Possibly in the future John.  I took the Belkin back and got a Netgear 
> WG311T for another $35.  Staples let me open it there and based on the 
> fact that the cd has some drivers on it that start with ATHE_* (the 
> chipset has a tincover soldered to the board over it so we can't ID it 
> that way), I'm assuming its an Atheros chipset, and Brian does has that 
> support available in DD-WRT, which is where this puppy will live.  But 
> I'm up to my butt in alligators ATM, so it may be a day or 3 till I can 
> try it.  I have a 160GB drive laying on the lappies carry case in the 
> doorway, to go up and be installed in the neighbors box to replace a 30GB 
> that upchucked all over their windows install, and convince it to let me 
> install windows on that box the 2nd time.  M$ are such rectums over that.  
> Its piracy you know. :(

Atheros makes a lot of different chipsets.  Not all are supported.  Many
newer ones require annoying firmware loaded into an arm processor on the
card.  Hopefully you found one that does have a working driver.

--
Len Sorensen
