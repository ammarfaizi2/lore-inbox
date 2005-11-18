Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVKRH5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVKRH5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKRH5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:57:07 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:21889 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932605AbVKRH5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:57:06 -0500
Date: Fri, 18 Nov 2005 08:56:58 +0100
From: Sander <sander@humilis.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-ID: <20051118075656.GA8311@favonius>
Reply-To: sander@humilis.net
References: <20051117111807.6d4b0535.akpm@osdl.org> <437D80BD.7030609@reub.net> <20051117234252.087fa813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117234252.087fa813.akpm@osdl.org>
X-Uptime: 08:41:42 up 16:22, 16 users,  load average: 2.27, 2.28, 2.64
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote (ao):
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> > On 18/11/2005 8:18 a.m., Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
> > > 
> > > - reiser4 significantly updated
> > > 
> > > 
> > > 
> > > 
> > > Changes since 2.6.14-mm2:
> > 
> > This has been one of the best -mm releases in a while.  No problems compiling
> > or running - and so far nearly 18 hours uptime without any surprises.

I second this. It is stable under (my) load where the 2.6.14-mm releases
crashed. Most likely due to Reiser4, but couldn't capture anything yet
(netconsole troubles, have to investigate more) so not sure.

Reiser4 is very slow though, as is discussed on the reiserfs list atm.

> We'll have to try harder.  -mm2 is up there now, to break everything again.

Nice :-)

-- 
Humilis IT Services and Solutions
http://www.humilis.net
