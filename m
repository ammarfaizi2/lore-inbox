Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWCMTBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWCMTBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWCMTBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:01:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12813 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751550AbWCMTBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:01:11 -0500
Date: Mon, 13 Mar 2006 20:01:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
Message-ID: <20060313190109.GC13973@stusta.de>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <20060313182725.GA31211@mars.ravnborg.org> <1142275289.13256.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142275289.13256.1.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 01:41:27PM -0500, Lee Revell wrote:
> On Mon, 2006-03-13 at 19:27 +0100, Sam Ravnborg wrote:
> > # latencies up to 80% slower
> 
> This is certainly bullshit, it has not been true since 2.6.7 or so.
> 
> Did not visit the page but that list smells like they are selling
> something.

The might be issues already fixed in 2.6.15 (he tested the then-current 
2.6.11.7) or there might be powerpc specific problems, but after a quick 
look at this page it looks like a serious page.

He also posted the complete lmbench results, dmesg's and .config's at 
his page, and from a first view I'd say he has very well documented 
what and how he measured.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

