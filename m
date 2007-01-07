Return-Path: <linux-kernel-owner+w=401wt.eu-S964827AbXAGSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbXAGSML (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbXAGSML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:12:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43710 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964827AbXAGSMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:12:09 -0500
Date: Sun, 7 Jan 2007 18:21:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107182151.7cc544f3@localhost.localdomain>
In-Reply-To: <20070107153833.GA21133@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	<20070107114439.GC21613@flint.arm.linux.org.uk>
	<45A0F060.9090207@imap.cc>
	<1168182838.14763.24.camel@shinybook.infradead.org>
	<20070107153833.GA21133@flint.arm.linux.org.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, in short, UTF-8 is all fine and dandy if your _entire_ universe
> is UTF-8 enabled.  If you're operating in a mixed charset environment
> it's one bloody big pain in the butt.

Net ASCII is 7bit and is 1:1 mapped with UTF-8 unicode. It's just old
broken 8bit encodings that are problematic.

The kernel maintainers/help/config pretty consistently use UTF8
