Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTIIXWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTIIXWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:22:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:11956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265237AbTIIXWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:22:47 -0400
Date: Tue, 9 Sep 2003 16:29:22 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Linux usb mailing list <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Driver model problems in -test5: usb this time
In-Reply-To: <20030909230118.GF211@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309091628000.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The latter two functions do not exist in -test5. It would helpful if you 
> > tried to reproduce with a virgin -test5. It would be courteous to state 
> > what patches you applied on top of the virgin -test5 kernel. 
> 
> Lot of them, but only "revert to -test3 swsusp" should be important
> here.

Then all bets are off. I cannot expect to reproduce the problems until you 
narrow down which patch causes the problem or verify that it appears on a 
standard kernel release.


	Pat

