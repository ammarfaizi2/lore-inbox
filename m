Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTENWco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTENWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:32:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:57606 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263078AbTENWcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:32:43 -0400
Date: Wed, 14 May 2003 23:45:28 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Vesa fix
In-Reply-To: <1052866894.1206.16.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305142344340.14201-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > XFree86 seems to do a pretty good job of getting it right, maybe they
> > have blacklists ? Then again, this stuff is arguably better off done
> > in userspace anyway IMO.

Not helpful on platforms which lack a hardware text mode.
 
> XFree handles EDID per driver and uses different methods in different
> drivers.

So I found out the hardware. BIOS are evil!!!!!

