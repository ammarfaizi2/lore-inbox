Return-Path: <linux-kernel-owner+w=401wt.eu-S965292AbXAHBZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbXAHBZZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbXAHBZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:25:25 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:53254 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965292AbXAHBZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:25:25 -0500
Date: Mon, 8 Jan 2007 02:22:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
In-Reply-To: <20070107223055.1dc7de54@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0701080221500.28861@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
 <1168182838.14763.24.camel@shinybook.infradead.org>
 <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain>
 <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr>
 <20070107223055.1dc7de54@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 7 2007 22:30, Alan wrote:
>
>> >The kernel maintainers/help/config pretty consistently use UTF8
>> 
>> I've seen a lot of places that don't do so. Want a patch?
>
>I think that would be a good idea - and add it to the coding/docs specs
>that documentation is UTF-8. Code should IMHO say 7bit though.

Hm, what do the list of authors in .c/.h files and kerneldoc
in .c/h belong to? doc or code?


	-`J'
-- 
