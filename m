Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752305AbWKDDP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbWKDDP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 22:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbWKDDP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 22:15:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51205 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752274AbWKDDP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 22:15:57 -0500
Date: Sat, 4 Nov 2006 04:15:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.19-rc4: known unfixed regressions
Message-ID: <20061104031557.GN13381@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061031195654.GV27968@stusta.de> <20061031201111.GA17260@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031201111.GA17260@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 12:11:11PM -0800, Greg KH wrote:
> On Tue, Oct 31, 2006 at 08:56:54PM +0100, Adrian Bunk wrote:
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
> This seems to be now fixed by using the proper pci config accesses.

Jeff, can you confirm MMCONFIG that is working again?

> thanks,
> 
> greg k-h

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

