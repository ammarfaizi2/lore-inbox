Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVIBS1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVIBS1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVIBS1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:27:25 -0400
Received: from web30306.mail.mud.yahoo.com ([68.142.200.99]:30633 "HELO
	web30306.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750797AbVIBS1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:27:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=A2wv6woRqIMPEAmij2M/nSQJuKMzIythnPJjz49fEo2EcTsyCsVIQY3ikPktwYj8k1q2rzMgMadHWUP83ZUqM6Bi0MywV3s7O1K0RD5IVSauXLd6GoNSL6/W09sTxtOgi396GDCq6p0kxJqcxOHgnDgZw3ZHJkTX38DYYdW6A0M=  ;
Message-ID: <20050902182720.54670.qmail@web30306.mail.mud.yahoo.com>
Date: Fri, 2 Sep 2005 19:27:20 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: How to create patch statistics?
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050902172824.GR3657@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all your quick responses.

Cheers,
Mark

--- Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Sep 02, 2005 at 06:22:32PM +0100, Mark
> Underwood wrote:
> 
> > Sorry to ask such a n00b question, but how do you
> > create the patch statistics that many people show
> at
> > the top of a patch set? I couldn’t see it the the
> > SubmittingPatches doc and google didn’t help (or I
> > don’t know what to look for ;)
> 
>   diffstat -p1 -w72 /path/to/patch
> 
> > Cheers,
> > 
> > Mark
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan
> asked suddenly out
>         of the darkness. There had been need of rain
> for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck
> - Dragon Seed
> 
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
