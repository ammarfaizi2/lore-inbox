Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUIHMfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUIHMfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUIHMfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:35:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23425 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262406AbUIHMfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:35:10 -0400
Date: Wed, 8 Sep 2004 07:34:12 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Michael.Waychison@Sun.COM,
       plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040908073412.3b7c9388@localhost>
In-Reply-To: <52isapkg9z.fsf@topspin.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com>
	<52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
	<52ekljq6l2.fsf@topspin.com>
	<20040907133332.4ceb3b5a@localhost>
	<52isapkg9z.fsf@topspin.com>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With the 3.9 tg3 driver, neither SoL nor the real network seems to
> ever come back.  As far as I can tell, the network is dead (and
> without SoL there's no way for me to see what happens to the kernel).
> 
> Have you had success with the latest tg3 on JS20?

I've had mixed results.  On some of my blades it never works.  On others
it will come up every third attempt or so.

Thanks,
Jake
