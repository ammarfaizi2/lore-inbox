Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWCYSEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWCYSEx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWCYSEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:04:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43279 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751053AbWCYSEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:04:52 -0500
Date: Sat, 25 Mar 2006 19:04:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] schedule the SCSI qlogicfc driver for removal
Message-ID: <20060325180451.GJ4053@stusta.de>
References: <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <20051027190227.GA16211@infradead.org> <20051027215313.GB7889@plap.qlogic.org> <20051028225155.GA13958@infradead.org> <20051028230303.GI15018@plap.qlogic.org> <1130542543.23729.160.camel@localhost.localdomain> <20060204225801.GD4528@stusta.de> <20060214001409.GA17604@stusta.de> <20060214174308.GA25817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214174308.GA25817@infradead.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:43:09PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 14, 2006 at 01:14:09AM +0100, Adrian Bunk wrote:
> > As usual, there isn't much feedback regarding problems with one driver 
> > from people using an obsolete driver for the same hardware.
> > 
> > So schedule the SCSI qlogicfc driver for removal and let the 
> > flames^Wfeedback begin...
> 
> The driver has been deprecatedd since long before the official deprecation
> mechanisms existed.  It'll go away for 2.6.17.

Is this patch pending somewhere or should I send a patch?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

