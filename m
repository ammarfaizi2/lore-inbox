Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVLVXMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVLVXMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVLVXMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:12:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37127 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030362AbVLVXMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:12:15 -0500
Date: Fri, 23 Dec 2005 00:12:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.de,
       herbert@gondor.apana.org.au, michael.madore@gmail.com,
       david-b@pacbell.net, gregkh@suse.de, paulmck@us.ibm.com, gohai@gmx.net,
       luca.risolia@studio.unibo.it, p_christ@hol.gr
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-ID: <20051222231213.GB27525@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051222011320.GL3917@stusta.de> <20051222005209.0b1b25ca.akpm@osdl.org> <20051222135718.GA27525@stusta.de> <20051222060827.dcd8cec1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222060827.dcd8cec1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 06:08:27AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > not a post-2.6.14 regression
> >
> 
> Well yeah.  But that doesn't mean thse things have lower priority that
> post-2.6.14 regressions.
> 
> I understand what you're doing here, but we should in general concentrate
> upon the most severe bugs rather than upon the most recent..

Regressions are worse than other bugs since they break working setups 
after a kernel upgrade, and should therefore be fixed before 2.6.15 
gets released.

This should in no way imply that other severe bugs shouldn't be fixed.

One thing why I'm currently pointing to such regressions is that I can't 
stand people whining noone would test -rc kernels while we aren't even 
able to handle all the regressions reported by people who actually do 
test our -rc kernels.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

