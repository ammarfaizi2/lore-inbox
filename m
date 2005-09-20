Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVITPci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVITPci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVITPci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:32:38 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:5794 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S965043AbVITPci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:32:38 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Tue, 20 Sep 2005 17:32:31 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Sean <seanlkml@sympatico.ca>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <20050920153231.GA2958@localhost.localdomain>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org> <200509201005.49294.gene.heskett@verizon.net> <20050920141008.GA493@flint.arm.linux.org.uk> <200509201025.36998.gene.heskett@verizon.net> <56402.10.10.10.28.1127229646.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56402.10.10.10.28.1127229646.squirrel@linux1>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 11:20:46AM -0400 Sean wrote:

> On Tue, September 20, 2005 10:25 am, Gene Heskett said:
> 
> > Humm, what are they holding out for, more ram or more cpu?:-)
> >
> > FWIW, http://master.kernel.org doesn't show it either just now.
> 
> Gene,
> 
> While kernel.org snapshots will no doubt be working again shortly, you
> might want to consider using git.  It reduces the amount you have to
> download for each release a lot.
> 
> It's really easy to grab a copy of git and use it to grab the kernel:
> 
> mkdir kernel
> cd kernel
> wget http://kernel.org/pub/software/scm/git/git-core-0.99.7.tar.bz2
> tar -xvjf git-core-0.99.7.tar.bz2
> cd git-core-0.99.7
> make install
> cd ..
> 
> git clone \
> rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
> linux
> 
> cd linux
> git checkout
> 

ketchup <version>
