Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWJHSPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWJHSPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWJHSPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:15:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22799 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751301AbWJHSPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:15:52 -0400
Date: Sun, 8 Oct 2006 20:15:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008181546.GH6755@stusta.de>
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com> <20061008045522.GG29474@stusta.de> <1160283948.10192.3.camel@lade.trondhjem.org> <20061008063943.GB6755@stusta.de> <84144f020610080045s6d2d1b06o6fc78bfb8fbf4d77@mail.gmail.com> <20061008172859.GD6755@stusta.de> <20061008173445.GN30283@lug-owl.de> <20061008175908.GG6755@stusta.de> <20061008180437.GO30283@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008180437.GO30283@lug-owl.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 08:04:37PM +0200, Jan-Benedict Glaw wrote:
> On Sun, 2006-10-08 19:59:08 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> > > Read the bug report: Seems it
> > > was actually caused by a non-initialized variable introduced by a
> > > patch to util-linux.
> > 
> > It was the sum of two independent bugs, and one of them was a kernel bug.
> 
> Without reading the sources but only the bug report, my impression is
> that the kernel code is correct.

It seems you missed Comment #1 when reading the bug report?

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

