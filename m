Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVAJWIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVAJWIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAJWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:06:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12562 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262724AbVAJWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:04:34 -0500
Date: Mon, 10 Jan 2005 23:04:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stephen_pollei@comcast.net, rmk+lkml@arm.linux.org.uk
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Message-ID: <20050110220426.GF2903@stusta.de>
References: <20050110184307.GB2903@stusta.de> <1105382033.12054.90.camel@localhost.localdomain> <41E2F1BD.1020407@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2F1BD.1020407@drzeus.cx>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:21:01PM +0100, Pierre Ossman wrote:
> 
> I think I've fixed the problem now. It wasn't that there were published 
> records for stusta.de, the problem was that the mail server couldn't 
> resolve your domain. For some reason everything from the DNS I'm using 
> to your DNS gets dropped. The mail server takes the paranoid route and 
> assumes the worst when it cannot contact dns servers (that's why you got 
> a 4xx, not a 5xx). I've now changed DNS which will hopefully solve the 
> issue.

Which DNS server du you call "your DNS"?

> As for dropping the mailing list out of MAINTAINERS then I'd prefer you 
> didn't (of course). But I will not remove the filters on the servers 
> since they remove a lot of spam. If that means it cannot be in 
> MAINTAINERS, then so be it.

I thought this was a wanted rejecting of my emails, and it's not so easy 
to contact you if you drop my emails...

Simply consider my patch being void.

> Rgds
> Pierre

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

