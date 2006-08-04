Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWHDHZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWHDHZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWHDHZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:25:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:26500 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161090AbWHDHZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:25:50 -0400
Date: Fri, 4 Aug 2006 00:20:49 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/23] -stable review
Message-ID: <20060804072049.GA5226@suse.de>
References: <20060804053807.GA769@kroah.com> <als5d2poja909k80kb5c2e2e6cuhboou7v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <als5d2poja909k80kb5c2e2e6cuhboou7v@4ax.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 05:18:44PM +1000, Grant Coady wrote:
> On Thu, 3 Aug 2006 22:38:07 -0700, Greg KH <gregkh@suse.de> wrote:
> >I've also posted a roll-up patch with all changes in it if people want
> >to test it out.  It can be found at:
> >
> >	kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz
> 
> It wasn't clear that this is a delta 2.6.17.7 -> 2.6.17.8 patch ;)
> 
> Didn't bump version:
> grant@sempro:~/linux/linux-2.6.17.8-rc1$ head -5 Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 17
> EXTRAVERSION = .7
> NAME=Crazed Snow-Weasel

Ugh, you are right, I normally don't bump the version until I commit the
patches to the tree.  Sorry about that, I'll fix that up next time.

> On the bright side, it compiled and runs ;)

Great, thanks for testing and letting us know, I really appreciate it.

greg k-h
