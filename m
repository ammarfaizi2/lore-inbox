Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVEOVgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVEOVgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEOVgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 17:36:23 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:39947 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261259AbVEOVgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 17:36:19 -0400
Date: Sun, 15 May 2005 23:38:32 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
Message-ID: <20050515213832.GB24179@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl> <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505151121.36243.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 11:21:36AM -0400, Gene Heskett wrote:
> >FreeBSD used these barriers (FLUSH CACHE command) long time ago.
> >
> >There are rumors that some disks ignore FLUSH CACHE command just to
> > get higher benchmarks in Windows. But I haven't heart of any proof.
> > Does anybody know, what companies fake this command?
> >
> >From a story I read elsewhere just a few days ago, this problem is 
> virtually universal even in the umpty-bucks 15,000 rpm scsi server 
> drives.  It appears that this is just another way to crank up the 
> numbers and make each drive seem faster than its competition.

 Probably you talking about this: http://www.livejournal.com/~brad/2116715.html
It has hit Slashdot yesterday.

-- 
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."

