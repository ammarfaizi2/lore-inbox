Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVHIP0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVHIP0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVHIP0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:26:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56071 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964820AbVHIP03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:26:29 -0400
Date: Tue, 9 Aug 2005 17:26:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] util-linux 2.13-pre1
Message-ID: <20050809152624.GW4006@stusta.de>
References: <20050802230751.GB4029@stusta.de> <42F897B2.9090404@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F897B2.9090404@draigBrady.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 12:46:58PM +0100, P@draigBrady.com wrote:
> Adrian Bunk wrote:
> >util-linux 2.13-pre1 is available at
> >  ftp://ftp.kernel.org/pub/linux/utils/util-linux/testing/util-linux-2.13-pre1.tar.gz
> 
> You missed my fixes to cal to fix a possible crash bug
> for certain terminal types, and to fix date alignment
> issues for certain dates. I've rediffed the attached
> patched against 2.13-pre1.

Yes sorry, this patch is still part of the big batch of util-linux 
emails I have to go through.

> Also schedutils build is breaking on redhat 9.
> This really is messy but should be handled.
> http://mail.linux.ie/pipermail/ilug/2004-November/019784.html
> API changes in same minor version of glibc should just not happen.

The URL seems to be invalid, but I know what you are talking about, and 
a fix is already on my TODO list to be implemented before the final 2.13
release.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

