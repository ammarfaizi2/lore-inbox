Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbTGDJUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbTGDJUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:20:04 -0400
Received: from albireo.ucw.cz ([81.27.194.19]:61188 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S265892AbTGDJUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:20:02 -0400
Date: Fri, 4 Jul 2003 11:34:28 +0200
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PCI] Various legacy probing options
Message-ID: <20030704093428.GK505@ucw.cz>
References: <20030623152310.GG2620@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623152310.GG2620@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Are there really broken PCs out there that will have additional bridges
> found in the PIRQ tables after pcibios_last_bus?

Probably not, but many of the ancient BIOSes just set the last bus to 0xff.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Dijkstra probably hates me." -- /usr/src/linux/kernel/sched.c
