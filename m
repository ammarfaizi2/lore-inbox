Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbTIZGHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTIZGHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:07:21 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:32899 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261951AbTIZGHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:07:18 -0400
Date: Fri, 26 Sep 2003 02:07:07 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: miltonm@bga.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [yoh@onerussian.com: Re: USB problem. 'irq 9: nobody cared!']
Message-ID: <20030926060707.GA29044@washoe.rutgers.edu>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>, miltonm@bga.com,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <20030926033306.GA27234@washoe.rutgers.edu> <20030925204841.4c6812ec.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925204841.4c6812ec.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure - you can see whole trace in dmesg @

http://www.onerussian.com/Linux/bug.USB/

there are some other files which might give some more information about
the system.

Thanks for your interest

Sincerely

--Yarik
On Thu, Sep 25, 2003 at 08:48:41PM -0700, Randy.Dunlap wrote:
> On Thu, 25 Sep 2003 23:33:06 -0400 Yaroslav Halchenko <yoh@onerussian.com> wrote:
> 
> | Sorry guys - probably I'm tired now not yesterday - that time I booted
> | in old good test4-bk3 (I didn't run lilo before boot).
> | 
> | In recent test5-bk12 with that patch I still get the same problem
> | irq 9: nobody cared!
> | Call Trace:
> |  [<c010b71a>] __report_bad_irq+0x2a/0x90
> |  [<c010b810>] note_interrupt+0x70/0xb0
> | ..
> | Disabling IRQ #9
> | 
> | 
> | Sorry about this...
> | 
> | I wish I could help more to resolve this problem
> 
> Hi,
> 
> I don't know the entire history here.
> Have you posted the full call trace instead of one that was cut short
> (as the one above is)?
> 
> Thanks.
> --
> ~Randy
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
