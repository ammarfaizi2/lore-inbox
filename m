Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRHAOgr>; Wed, 1 Aug 2001 10:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbRHAOgi>; Wed, 1 Aug 2001 10:36:38 -0400
Received: from 2Cust215.tnt1.cbr1.da.uu.net ([210.84.113.215]:50567 "EHLO
	backdraft") by vger.kernel.org with ESMTP id <S267140AbRHAOg1>;
	Wed, 1 Aug 2001 10:36:27 -0400
Date: Thu, 2 Aug 2001 00:36:07 +1000
From: Patrick Cole <z@amused.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip driver still broken
Message-ID: <20010802003607.A9699@backdraft.amused.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010730180814.27870D-100000@mandrakesoft.mandrakesoft.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 30, 2001 at 06:09:33PM -0500, Jeff Garzik wrote:

> On Mon, 30 Jul 2001, Joshua Schmidlkofer wrote:
>
> > I am afraid of post these days.  However, I must comment that I too am having 
> > trouble with the tulip driver, on several SMC nic's that use the DEC  
> > chipset.  I tried mii_tool, with no success.
> > 
> > I have just been copying the tulip driver from 2.4.4 forward...   because I 
> > don't have enough time to try and create an intelligent error report.
> 
> Thanks for the report!
> 
> Currently there are problems with 21041 old chipsets, which include SMC
> and several other cards.  You can use 0.9.14 from
> http://sf.net/projects/tulip/ until I get around to fixing it.

My 21041 is also not working with late 2.4 series tulip drver. I've heard the
de4x5 driver does however work.

-- 
Patrick Cole - Debian Developer    <ltd@debian.org>
             - Linux.com Volunteer <z@linux.com>
             - ANU JCSMR ICU Staff <Patrick.Cole@anu.edu.au>
             - PGP 1024R/60D74C7D  C8 E0 BC 79 69 BE 78 99 
                                   AA 0F EB 16 F8 4B FE 5A   
