Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTICT7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264317AbTICT57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:57:59 -0400
Received: from relay.pair.com ([209.68.1.20]:27656 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264286AbTICT4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:56:05 -0400
X-pair-Authenticated: 68.40.145.213
Subject: Re: Scaling noise
From: Daniel Gryniewicz <dang@fprintf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1062612665.19982.3.camel@dhcp23.swansea.linux.org.uk>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
	 <20030903173213.GC5769@work.bitmover.com>
	 <1062612665.19982.3.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062618962.3786.30.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Sep 2003 15:56:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 14:11, Alan Cox wrote:
> On Mer, 2003-09-03 at 18:32, Larry McVoy wrote:
> > For a lot of applications we are.  Go talk to your buddies in the processor
> > group, I think there is a fair amount of awareness that for most apps faster
> > processors aren't doing any good.  Ditto for SMP.
> 
> >From the app end I found similar things. My gnome desktop performance
> doesn't measurably improve beyond about 7-800Mhz. Some other stuff like
> mozilla benefits from more CPU and 3D game stuff can burn all it can
> get.

Interesting.  I've found that my Athlon XP 2200 is noticably faster at
Gnome than my Athlon MP 1500 (running a UP kernel).  The memory and disk
is the same speed, so only the processor is different, unless the
chipsets make a huge difference.  Of course, both are much faster than
my 1 GHz Athlon laptop, but there's also a large disk/memory speed
difference there.

-- 
Daniel Gryniewicz <dang@fprintf.net>
