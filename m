Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTJRUsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTJRUsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:48:51 -0400
Received: from adsl-215-226.38-151.net24.it ([151.38.226.215]:42769 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261812AbTJRUsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:48:50 -0400
Date: Sat, 18 Oct 2003 22:48:47 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031018204847.GA1117@renditai.milesteg.arr>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031015172742.GZ30375@earth.li> <20031015210054.GA1492@picchio.gall.it> <20031016140644.GJ1659@openzaurus.ucw.cz> <20031018175423.GA1038@renditai.milesteg.arr> <20031018180102.GA461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018180102.GA461@elf.ucw.cz>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 08:01:02PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Look at the logs, perhaps you have an oops?
> > 
> > Trying with -test8 I keep getting my bash killed, but there is more, now
> > it seesms that the sis900 network driver broke, because after resume my
> > NIC does not work anymore and I get timeouts sending packets.
> 
> Did sis900 driver work in -test7?

Yes, mmmh, well, perhaps I didn't test...
Tomorrow I'll try and let you know.

Sorry for the double post.
Thanks, bye.

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

