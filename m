Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbTIZDtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 23:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTIZDtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 23:49:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:8395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261716AbTIZDtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 23:49:42 -0400
Date: Thu, 25 Sep 2003 20:48:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yaroslav Halchenko <yoh@onerussian.com>
Cc: miltonm@bga.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [yoh@onerussian.com: Re: USB problem. 'irq 9: nobody cared!']
Message-Id: <20030925204841.4c6812ec.rddunlap@osdl.org>
In-Reply-To: <20030926033306.GA27234@washoe.rutgers.edu>
References: <20030926033306.GA27234@washoe.rutgers.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003 23:33:06 -0400 Yaroslav Halchenko <yoh@onerussian.com> wrote:

| Sorry guys - probably I'm tired now not yesterday - that time I booted
| in old good test4-bk3 (I didn't run lilo before boot).
| 
| In recent test5-bk12 with that patch I still get the same problem
| irq 9: nobody cared!
| Call Trace:
|  [<c010b71a>] __report_bad_irq+0x2a/0x90
|  [<c010b810>] note_interrupt+0x70/0xb0
| ..
| Disabling IRQ #9
| 
| 
| Sorry about this...
| 
| I wish I could help more to resolve this problem

Hi,

I don't know the entire history here.
Have you posted the full call trace instead of one that was cut short
(as the one above is)?

Thanks.
--
~Randy
