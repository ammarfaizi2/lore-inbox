Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUINXHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUINXHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUINXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:03:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:59850 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268051AbUINW74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:59:56 -0400
Date: Tue, 14 Sep 2004 17:58:45 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: "David S. Miller" <davem@davemloft.net>, Anton Blanchard <anton@samba.org>,
       roland@topspin.com, plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040914175845.2e1d90ca@localhost>
In-Reply-To: <41476E92.6020609@sun.com>
References: <412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com>
	<52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
	<52ekljq6l2.fsf@topspin.com>
	<20040907133332.4ceb3b5a@localhost>
	<52isapkg9z.fsf@topspin.com>
	<20040908073412.3b7c9388@localhost>
	<20040908130728.GA2282@krispykreme>
	<20040913154828.35d60ac1.davem@davemloft.net>
	<41476E92.6020609@sun.com>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've gone through the changes you've made lately and I found a thinko,
> patch attached.
> 
> With this patch, I can turn off autoneg on our b1600's switch and the
> b200x falls back to 1000FD as required.
> 
> Signed-Off: Mike Waychison <michael.waychison@sun.com>
> 

This is working on my JS20.   Nice work Mike.

Jake
