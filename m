Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVAZHod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVAZHod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVAZHod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:44:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61707 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262376AbVAZHob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:44:31 -0500
Date: Wed, 26 Jan 2005 08:44:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, irda-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dag@brattli.net
Subject: Re: [2.6 patch] update Dag Brattli's email address
Message-ID: <20050126074427.GO30909@stusta.de>
References: <20050125144046.GJ30909@stusta.de> <20050126005215.GA21409@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126005215.GA21409@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 04:52:15PM -0800, Chris Wedgwood wrote:
> On Tue, Jan 25, 2005 at 03:40:46PM +0100, Adrian Bunk wrote:
> 
> > This patch updates the email address of Dag Brattli in kernel 2.6 to
> > his current address.
> 
> >  drivers/net/irda/actisys-sir.c        |    4 ++--
> [ ... 
> >  CREDITS                               |    6 +-----
> >  96 files changed, 233 insertions(+), 237 deletions(-)
> 
> This patch is huge.
> 
> Do we really need email addresses in all these files?  How about we
> remove them and put it in ONE place instead so if it needs to be
> updated again we don't need to touch ~96 files?
> 
> Surely this makes sense in general too?

I have no strong opinions on this - in most places a simple removal of 
his email address might do as well.

But at least the CREDITS file and the 17 files where the address is 
listed in MODULE_AUTHOR need the correct address.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

