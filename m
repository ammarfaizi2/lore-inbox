Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVIBR2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVIBR2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVIBR2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:28:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16649 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbVIBR2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:28:33 -0400
Date: Fri, 2 Sep 2005 19:28:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mark Underwood <basicmark@yahoo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to create patch statistics?
Message-ID: <20050902172824.GR3657@stusta.de>
References: <20050902172232.62821.qmail@web30308.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050902172232.62821.qmail@web30308.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 06:22:32PM +0100, Mark Underwood wrote:

> Sorry to ask such a n00b question, but how do you
> create the patch statistics that many people show at
> the top of a patch set? I couldn’t see it the the
> SubmittingPatches doc and google didn’t help (or I
> don’t know what to look for ;)

  diffstat -p1 -w72 /path/to/patch

> Cheers,
> 
> Mark

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

