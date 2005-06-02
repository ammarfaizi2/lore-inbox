Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFBNeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFBNeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFBNeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:34:00 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:10458 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261417AbVFBNd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:33:58 -0400
Date: Thu, 2 Jun 2005 09:33:57 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
Message-ID: <20050602133357.GN23621@csclub.uwaterloo.ca>
References: <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com> <429EC91A.7020704@aitel.hist.no> <429EF4E2.2050907@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429EF4E2.2050907@tmr.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 08:00:34AM -0400, Bill Davidsen wrote:
> Unfortunately even drives in a dual power tray with redundany power from 
> separate UPS sources will occasionally have a power failure. Proved that 
> last month, the power strip in the rack failed, dumped all the load on 
> the other leg, the surge tripped a breaker. Had an APC UPS in my office 
> fail in a mode which dropped power, waited for the battery to trickle 
> charge to charge the battery a bit, then repeat. Looks to be losing half 
> of a full wave rectifier.
> 
> The point is that power failures WILL HAPPEN, even with good backups. 
> The goal should be to prevent excessive and avoidable data damage when 
> it does.
> 
> Shameless plug: for office use I changed from APC to Belkin on all new 
> units, they have had Linux drivers for some time now, and I like to 
> support those who support Linux.

Hasn't apcupsd existed for at least a decade?  Works rather well for me.
Hard to imagine better linux/unix support than APC seems to have
provided so far.

For some reason Belkin screms cheap junk to me.  Maybe that's because
that is what you always see for sale with that brand on it.  They may
have nice stuff that I just haven't seen because it isn't carried by
most stores.

Len Sorensen
