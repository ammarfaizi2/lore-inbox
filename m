Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTJRSBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJRSBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:01:21 -0400
Received: from gprs144-147.eurotel.cz ([160.218.144.147]:6016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261762AbTJRSBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:01:16 -0400
Date: Sat, 18 Oct 2003 20:01:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031018180102.GA461@elf.ucw.cz>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031015172742.GZ30375@earth.li> <20031015210054.GA1492@picchio.gall.it> <20031016140644.GJ1659@openzaurus.ucw.cz> <20031018175423.GA1038@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018175423.GA1038@renditai.milesteg.arr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Look at the logs, perhaps you have an oops?
> 
> Trying with -test8 I keep getting my bash killed, but there is more, now
> it seesms that the sis900 network driver broke, because after resume my
> NIC does not work anymore and I get timeouts sending packets.

Did sis900 driver work in -test7?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
