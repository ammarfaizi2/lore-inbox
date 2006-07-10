Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWGJROI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWGJROI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422713AbWGJROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:14:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45009 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422712AbWGJROH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:14:07 -0400
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <873bd9fobb.fsf@javad.com>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	 <1152302831.20883.63.camel@localhost.localdomain>
	 <87d5cdg308.fsf@javad.com>
	 <1152529855.27368.114.camel@localhost.localdomain>
	 <873bd9fobb.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 18:31:23 +0100
Message-Id: <1152552683.27368.185.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 19:54 +0400, ysgrifennodd Sergei Organov:
> Wow! The code you've quoted seems to be correct! But where did you get
> it from? The version of flush_to_ldisc() from drivers/char/tty_io.c from
> 2.17.4 got last Friday from kernel.org does this:

>From HEAD so it should make 2.6.18. Paul fixed this one.


Alan
