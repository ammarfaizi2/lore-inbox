Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVEOI1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVEOI1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 04:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVEOI1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 04:27:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42510 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261547AbVEOI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 04:27:11 -0400
Date: Sun, 15 May 2005 10:27:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andres Salomon <dilinger@athenacr.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Status of net/ipv4/ipvs/ip_vs_proto_icmp.c?
Message-ID: <20050515082706.GK16549@stusta.de>
References: <20050513041622.GE3603@stusta.de> <pan.2005.05.13.19.09.00.598647@athenacr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.05.13.19.09.00.598647@athenacr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:09:01PM -0400, Andres Salomon wrote:
> On Fri, 13 May 2005 06:16:22 +0200, Adrian Bunk wrote:
> 
> > Hi,
> > 
> > can anyone explain the status of?
> > 
> > This file is always included in the kernel if CONFIG_IP_VS=y, but it's 
> > completely unused.
> > 
> > Will it be made working in the forseeable future or is it a candidate 
> > for removal?
> > 
> > TIA
> > Adrian
> 
> The people/places to ask would probably be:
> 
> IPVS
> P:      Wensong Zhang
> M:      wensong@linux-vs.org
> P:      Julian Anastasov
> M:      ja@ssi.bg
> S:      Maintained
>...

And these are exactly the people in the To-header of the email asking 
this question.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

