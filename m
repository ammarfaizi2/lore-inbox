Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVEZRUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVEZRUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEZRRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:17:12 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:31919 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261651AbVEZROe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:14:34 -0400
Message-ID: <429605D7.941893D@tv-sign.ru>
Date: Thu, 26 May 2005 21:22:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
References: <4295F649.7040405@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> 
> With respect to this patch:
> 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0505.2/1537.html
> 
> I have looked at various ways of doing this and have concluded that this is the
> right patch.

Great!

> Oleg, could you resend?

It's in 2.6.12-rc5-mm1 tree already.

Oleg.
