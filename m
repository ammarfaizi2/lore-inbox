Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWG3SDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWG3SDk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWG3SDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:03:40 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:42975 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932398AbWG3SDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:03:39 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Rene Rebe <rene@exactcode.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <200607301937.15414.rene@exactcode.de>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <44CCE521.7090705@superbug.co.uk> <1154280337.13635.38.camel@localhost>
	 <200607301937.15414.rene@exactcode.de>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 20:03:38 +0200
Message-Id: <1154282618.13635.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 19:37 +0200, Rene Rebe wrote:
> Hi,
> 
> it would be totally ok if the kernel had a country= command line switch
> and the driver limitting functionality due that.
or simply state this in the help in Kconfig?
> 
> People that want to violate the local regulations would require to lie to
> the kernel as they could install other country windows and drivers as
> well.
besides, im not even sure that specifying in Kconfig is necessary,
wouldnt it only be illegal in countries, if people actually modified the
source?
> 
> Sure, people could modify the source as they could specify a wrong
> country argument. But you can heedit the windows binary as well.
> 
> Yours,
> 

