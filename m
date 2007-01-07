Return-Path: <linux-kernel-owner+w=401wt.eu-S965262AbXAGXtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbXAGXtF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbXAGXtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 18:49:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2836 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965258AbXAGXtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 18:49:01 -0500
Date: Mon, 8 Jan 2007 00:49:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Brice Goglin <brice@myri.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc3: known unfixed regressions (v4)
Message-ID: <20070107234904.GN20714@stusta.de>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070106210417.GA20714@stusta.de> <45A01D76.8080009@myri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A01D76.8080009@myri.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 11:06:46PM +0100, Brice Goglin wrote:
> Adrian Bunk wrote:
> > This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
> > that are not yet fixed in Linus' tree.
> >   
> 
> I reported another one yesterday, about HT MSI capability lookup being
> broken (can only find the first one in the chain). See
> http://lkml.org/lkml/2007/1/5/215. The patch works well here, but I
> didn't get any comment so far.
> 
> The regression has been confirmed by Robert Hancock.

Thanks, added to my list.

> Brice

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

