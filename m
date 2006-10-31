Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423600AbWJaUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423600AbWJaUVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423604AbWJaUVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:21:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58896 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423600AbWJaUVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:21:15 -0500
Date: Tue, 31 Oct 2006 21:21:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.19-rc4: known unfixed regressions
Message-ID: <20061031202114.GX27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061031195654.GV27968@stusta.de> <1162325537.3044.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162325537.3044.49.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:12:17PM +0100, Arjan van de Ven wrote:
> On Tue, 2006-10-31 at 20:56 +0100, Adrian Bunk wrote:
> > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> > that are not yet fixed in Linus' tree.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> > 
> > 
> > Subject    : PCI: MMCONFIG breakage
> > References : http://lkml.org/lkml/2006/10/27/251
> > Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> > Status     : unknown, both BIOS and Direct work
> 
> hmm I see nothing MMCONFIG related here much....

The "both BIOS and Direct work" is a result of the discussion in the 
later emails of the thread, leaving MMCONFIG.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

