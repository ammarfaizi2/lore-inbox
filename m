Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTIZMkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTIZMkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:40:52 -0400
Received: from c180121.adsl.hansenet.de ([213.39.180.121]:56996 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S261829AbTIZMkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:40:51 -0400
Date: Fri, 26 Sep 2003 14:34:52 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: yoh@onerussian.com, linux-kernel@vger.kernel.org
Subject: Re: [yoh@onerussian.com: Re: USB problem. 'irq 9: nobody cared!']
Message-ID: <20030926123452.GA8452@ppp0.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>, yoh@onerussian.com,
	linux-kernel@vger.kernel.org
References: <20030926033306.GA27234@washoe.rutgers.edu> <20030925204841.4c6812ec.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925204841.4c6812ec.rddunlap@osdl.org>
I-love-doing-this: really
X-Modeline: vim:set ts=8 sw=4 smarttab tw=72 si noic notitle:
X-Operating-System: Linux/2.4.22aa1 (i686)
X-Uptime: 13:56:02 up 24 days,  3:53, 12 users,  load average: 0.15, 0.11, 0.09
Accept-Languages: de, en, fr
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rddunlap@osdl.org> wrote on 2003-09-25 20:48:41
> On Thu, 25 Sep 2003 23:33:06 -0400 Yaroslav Halchenko <yoh@onerussian.com> wrote:
> 
> | Sorry guys - probably I'm tired now not yesterday - that time I booted
> | in old good test4-bk3 (I didn't run lilo before boot).
> | 
> | In recent test5-bk12 with that patch I still get the same problem
> | irq 9: nobody cared!
 
> I don't know the entire history here.
> Have you posted the full call trace instead of one that was cut short
> (as the one above is)?
> 
See

http://marc.theaimsgroup.com/?l=linux-kernel&m=106431078301884&w=2

Also note the strange /proc/interrupts count on irq 9.
Yaroslav, are you seeing this also?

Thanks,

  Jan

--
Jan Dittmer - jdittmer@ppp0.net
