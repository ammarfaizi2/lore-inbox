Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWDTRBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWDTRBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDTRBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:01:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751152AbWDTRA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:00:56 -0400
Date: Thu, 20 Apr 2006 19:00:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Antti Halonen <antti.halonen@secgo.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: searching exported symbols from modules
Message-ID: <20060420170055.GV25047@stusta.de>
References: <963E9E15184E2648A8BBE83CF91F5FAF43619E@titanium.secgo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF43619E@titanium.secgo.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 10:15:42AM +0300, Antti Halonen wrote:
>...
> > A large number of people on this list (including
> > copyright-holders) consider what you are doing blatantly illegal,
> > although nobody has yet gone to court over it.  
> 
> Um, which part is illegal? Are you saying that I cannot have a non-open
> source kernel module? If I figured correctly, to violate GPL I should
> compile GPL code into my module.
> 
> It is a standalone module, not distributed with any custom kernel.
>...

A short discussion is e.g. at [1]. But AFAIK none of this has yet been 
brought to court.

Things are even more funny considering that if you distribute your 
module in N countries, you can be sued in N different countries based on 
N different copyright laws...

> Br,
> Antti

cu
Adrian

[1] http://en.wikipedia.org/wiki/Linux_kernel#Licensing_terms

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

