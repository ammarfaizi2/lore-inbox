Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbRFRU7H>; Mon, 18 Jun 2001 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbRFRU65>; Mon, 18 Jun 2001 16:58:57 -0400
Received: from [194.213.32.142] ([194.213.32.142]:3076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263032AbRFRU6r>;
	Mon, 18 Jun 2001 16:58:47 -0400
Message-ID: <20010617231129.A6466@bug.ucw.cz>
Date: Sun, 17 Jun 2001 23:11:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@skynet.ie>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux/VAX booting to a shell.
In-Reply-To: <Pine.LNX.4.32.0106161228490.18791-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.32.0106161228490.18791-100000@skynet>; from Dave Airlie on Sat, Jun 16, 2001 at 12:43:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi all, (mind crossposts on follow ups..)
> 
> attached below is a bootlog from the Linux/VAX port, booting up, loading
> up busybox/uClibc sh and cat /proc/cpuinfo, from my VAXStation 3100m38,
> 
> Thanks to the other two members of the core VAX porting team, Andy
> Phillips and Kenn Humborg and others on the linux-vax list who've given
> their help, this is the second major milestone for the project, (gcc
> porting was the first) now to get it working on a few other systems and
> move into userspace...

Congratulations. (This is pretty big machine, for the VAX, no? When
was it build? How much power does it take?)
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
