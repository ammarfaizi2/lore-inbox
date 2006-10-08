Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWJHGEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWJHGEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWJHGEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:04:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54282 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750824AbWJHGEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:04:14 -0400
Date: Sun, 8 Oct 2006 06:55:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008045522.GG29474@stusta.de>
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 09:43:51PM -0700, Trond Myklebust wrote:
> On Sat, 2006-10-07 at 23:46 +0200, Adrian Bunk wrote:
> 
> > Subject    : NFSv4 fails to mount (timeout)
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=7274
> > Submitter  : Torsten Kaiser <kernel@bardioc.dyndns.org>
> > Guilty     : Trond Myklebust <Trond.Myklebust@netapp.com>
> >              commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86
> > Handled-By : Trond Myklebust <Trond.Myklebust@netapp.com>
> > Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7274
> > Status     : patch available
> 
> Thanks... Always nice to hear that you have been judged and found
> guilty. Now go and reread that fucking bug report...

As far as I understand it it is the sum of two bugs, and one of them 
is the one from commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

