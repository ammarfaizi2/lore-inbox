Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWAJRtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWAJRtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWAJRtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:49:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38919 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932252AbWAJRtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:49:05 -0500
Date: Tue, 10 Jan 2006 18:49:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: sym53c8xx_2 is flooding my syslog ...
Message-ID: <20060110174904.GS3911@stusta.de>
References: <430FD71C.6050704@bigpond.net.au> <43632635.7080604@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43632635.7080604@bigpond.net.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 05:35:17PM +1000, Peter Williams wrote:
> Peter Williams wrote:
> >... with the following message:
> >
> >Aug 21 04:53:28 mudlark kernel: ..<6>sd 0:0:6:0: phase change 6-7 
> >9@01ab97a0 resid=7.
> >
> >every 2 seconds.  Since the problem being reported seems to have no 
> >effect on the operation of the scsi devices is it really necessary to 
> >report it so often?
> >
> 
> This problem is still occurring on 2.6.14.

And still in 2.6.15?

> Peter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

