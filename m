Return-Path: <linux-kernel-owner+w=401wt.eu-S965227AbXAGWUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbXAGWUi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbXAGWUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:20:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45230 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965227AbXAGWUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:20:37 -0500
Date: Sun, 7 Jan 2007 22:30:55 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107223055.1dc7de54@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	<20070107114439.GC21613@flint.arm.linux.org.uk>
	<45A0F060.9090207@imap.cc>
	<1168182838.14763.24.camel@shinybook.infradead.org>
	<20070107153833.GA21133@flint.arm.linux.org.uk>
	<20070107182151.7cc544f3@localhost.localdomain>
	<Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The kernel maintainers/help/config pretty consistently use UTF8
> 
> I've seen a lot of places that don't do so. Want a patch?

I think that would be a good idea - and add it to the coding/docs specs
that documentation is UTF-8. Code should IMHO say 7bit though.

Alan
