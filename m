Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUAKOZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUAKOZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:25:38 -0500
Received: from imap.gmx.net ([213.165.64.20]:6842 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265897AbUAKOZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:25:36 -0500
X-Authenticated: #20450766
Date: Sun, 11 Jan 2004 15:24:53 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040111135309.F1931@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0401111516250.4611-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Russell King wrote:

> Basically, the SMC91C111 is great for use on small, *well controlled*
> embedded networks, but anything else is asking for trouble.

Ok, thanks. Well, just out of curiousity (also, why I concluded it might
have been a more general problem - because I had it on both my ARM boards)
- where is the bottleneck likely to be on a SA system with a Netgear-FA411
PCMCIA card (NE2000-compatible)? Just a slow CPU?

Thanks
Guennadi
---
Guennadi Liakhovetski


