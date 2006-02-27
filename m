Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWB0HIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWB0HIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWB0HIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:08:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4612 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750993AbWB0HIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:08:30 -0500
Date: Mon, 27 Feb 2006 08:08:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       Randy Dunlap <rdunlap@xenotime.net>, linux-ide@vger.kernel.org
Subject: Re: 2.6.16-rc5: known regressions
Message-ID: <20060227070830.GQ3674@stusta.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de> <4402A219.8010501@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4402A219.8010501@pobox.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 01:54:17AM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> >References : http://lkml.org/lkml/2006/2/20/159
> >Submitter  : Mark Lord <lkml@rtr.ca>
> >Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> >Status     : one of Randy's patches seems to fix it
> 
> 
> This is not a regression, libata suspend/resume has always been crappy. 
>  It's under active development (by Randy, among others) to fix this.

It might have always been crappy, but it is a regression since
according to the submitter it is working with 2.6.15.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

