Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTD0XWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 19:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTD0XWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 19:22:51 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52233 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262000AbTD0XWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 19:22:50 -0400
Date: Mon, 28 Apr 2003 01:35:00 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
Message-ID: <20030427233500.GB1780@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com> <20030424083730.5F79A2127F@dungeon.inka.de> <20030424085913.GH28253@mail.jlokier.co.uk> <3EA804A8.8070608@techsource.com> <1051209350.4004.6.camel@dhcp22.swansea.linux.org.uk> <20030424192941.E1425@almesberger.net> <20030427142106.GA24244@merlin.emma.line.org> <20030427165959.GC6820@work.bitmover.com> <1051479168.15485.12.camel@dhcp22.swansea.linux.org.uk> <20030427223612.GI23068@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030427223612.GI23068@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Larry McVoy wrote:

> But you are still missing the point.  As long as the feeling is that it is
> OK to reverse engineer by staring at the file formats, the corporations
> will respond by encrypting the data you want to stare at.
> 
> In other words, it's pretty much hopeless to try and catch up that way,
> you might as well go try and build something better from the start.

Wouldn't you still want to import "old" data into the new BetterApp?

Changes of the format or interface are painful, we've seen this with the
network filtering in Linux several times, 2.0 had ipfwadm, 2.2 had
ipchains, 2.4 has compatibility interfaces for either and its native
netfilter... There must have been a better reason to add compatibility
than just "because we could do it."
