Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVAQQaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVAQQaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVAQQaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:30:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63755 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262246AbVAQQ3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:29:45 -0500
Date: Mon, 17 Jan 2005 17:29:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org, Klaus Dittrich <kladit@t-online.de>
Subject: Re: brought up 4 cpu's
Message-ID: <20050117162938.GS4274@stusta.de>
References: <20050117153646.GA25273@xeon2.local.here> <200501171609.15054.m.watts@eris.qinetiq.com> <41EBE54B.1010401@xeon2.local.here> <200501171632.26443.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501171632.26443.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 04:32:26PM +0000, Mark Watts wrote:
> 
> > Mark Watts wrote:
> > >
> > >>kernel-2.6.11-rc1-bk5 stops booting after the message
> > >>"Brought up 4 CPU'S"
> > >>
> > >>System is Dual-P4.
> > >
> > >With HyperThreading?
> >
> > Yes, 2 XEON/P4.
> 
> Thats your answer then. HyperThreading makes one cpu act as two (with a 
> suitable performance increase for some workloads)

This doesn't explain why it stopped booting on his computer...

> Mark.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

