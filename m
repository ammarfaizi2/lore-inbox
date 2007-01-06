Return-Path: <linux-kernel-owner+w=401wt.eu-S1751212AbXAFHle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbXAFHle (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXAFHle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:41:34 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:60925 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXAFHld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:41:33 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 6 Jan 2007 02:35:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
In-Reply-To: <20070106023604.GC24091@Ahmed>
Message-ID: <Pine.LNX.4.64.0701060235330.7755@localhost.localdomain>
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de>
 <20070105100610.GA382@Ahmed> <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
 <20070106023604.GC24091@Ahmed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, Ahmed S. Darwish wrote:

> > On Fri, Jan 05, 2007 at 09:10:01AM +0100, rday wrote:
> > > Ahmed S. Darwish wrote:
> > > Remove unnecessary kmalloc casts in drivers/char/tty_io.c
> > > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> >
> > rday
> >
> > p.s.  just FYI, i have a patch that does most of this, but i was going
> > to hold off submitting it until 2.6.20 had arrived.  but if you want
> > to take a shot at it, it's all yours.
>
> OK, then I should stop sending new patches related to that matter to
> avoid patch conflicts. right ?

no, no, go ahead.  i have enough to do to keep me busy.

rday
