Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWE3Q1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWE3Q1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWE3Q1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:27:21 -0400
Received: from ns.suse.de ([195.135.220.2]:19390 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932314AbWE3Q1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:27:20 -0400
Date: Tue, 30 May 2006 09:24:50 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Netdev list <netdev@vger.kernel.org>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: zd1201 & ipw2200 problems
Message-ID: <20060530162450.GA7092@kroah.com>
References: <20060530111712.GA32054@elf.ucw.cz> <20060530144120.GA15350@kroah.com> <20060530144742.GC27794@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530144742.GC27794@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 04:47:42PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > I see some strange problems with zd1201. (Ccing greg, he seen
> > > something similar).
> > 
> > Which zd1201 driver are you using?
> 
> In-tree one, 2.6.17-rc4 (and around). Ouch and I've "solved" the
> zaurus problme in the meantime -- it was hw one.

Oops, sorry, I was thinking of the zd1211 driver, which is still not in
the kernel tree and there are a few different versions floating around.

Glad it's working for you now.

greg k-h
