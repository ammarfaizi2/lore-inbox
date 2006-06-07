Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWFGPAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWFGPAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFGPAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:00:45 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:60347 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932230AbWFGPAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:00:45 -0400
Date: Wed, 7 Jun 2006 17:00:43 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: jvbest@qv3pluto.leidenuniv.nl, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: NI5010 network driver -- MAINTAINERS entry
Message-ID: <20060607150043.GA30512@rhlx01.fht-esslingen.de>
References: <20060607142213.GA3618@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607142213.GA3618@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 07, 2006 at 04:22:14PM +0200, Pavel Machek wrote:
> 
> ...is quite inconsistent with rest of file:
> 
> NI5010 NETWORK DRIVER
> P:      Jan-Pascal van Best and Andreas Mohr
> M:      Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
> M:      Andreas Mohr <100.30936@germany.net>
> L:      netdev@vger.kernel.org
> S:      Maintained
> 
> probably should be
> 
> NI5010 NETWORK DRIVER
> P:      Jan-Pascal van Best
> M:      jvbest@qv3pluto.leidenuniv.nl
> P:	Andreas Mohr
> M:      100.30936@germany.net

Err, not quite ;)

> L:      netdev@vger.kernel.org
> S:      Maintained
> 
> ...yes, "new" mail address format makes sense, but I guess whole file
> should be converted.

Right, I've been looking at this entry some time ago and thought that I
should send an update patch, but haven't gotten around to doing that yet.

Problem is that I'm not actively using this (admittedly historic) card
any more, so bug reports about this driver would probably have to be fixed
by the reporter or alternatively get delayed some time (I'm willing to
look into any reports, so status "Maintained" would still be sort of valid,
I think).

My currently "best" mail address is andi@lisas.de, not sure about
the validity of Jan-Pascal van Best's address, though.

Should I send an update patch (to -mm tree?), or do you want to do it?

Andreas Mohr
