Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269386AbTCDQRX>; Tue, 4 Mar 2003 11:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269407AbTCDQRX>; Tue, 4 Mar 2003 11:17:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26640 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269386AbTCDQRW>; Tue, 4 Mar 2003 11:17:22 -0500
Date: Tue, 4 Mar 2003 17:27:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030304162745.GC711@atrey.karlin.mff.cuni.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030303001032.GD319@elf.ucw.cz> <1046794561.12066.42.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046794561.12066.42.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [bk's on-disk format is quite reasonable; it might be okay to reuse
> > that.]
>
> I disagree. Keeping the checked-out files _outside_ the repository, and
> being able to have multiple checked-out trees from the same repository
> with uncommitted changes outstanding while you pull from a remote
> repository, etc, is useful.

Agreed, but bk's SCCS-based format does not prevent you from keeping
checked-out files outside repository or from having multiple
checked-out trees. In fact I'm doing exactly that with bitbucket.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
