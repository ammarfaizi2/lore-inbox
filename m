Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUINWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUINWne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUINWkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:40:47 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:2225
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266189AbUINWik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:38:40 -0400
Date: Tue, 14 Sep 2004 15:36:20 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: anton@samba.org, moilanen@austin.ibm.com, roland@topspin.com,
       plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040914153620.3dcac662.davem@davemloft.net>
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
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 18:20:02 -0400
Mike Waychison <Michael.Waychison@Sun.COM> wrote:

> I've gone through the changes you've made lately and I found a thinko,
> patch attached.
> 
> With this patch, I can turn off autoneg on our b1600's switch and the
> b200x falls back to 1000FD as required.
> 
> Signed-Off: Mike Waychison <michael.waychison@sun.com>

Thanks Mike, come up to SF and I'll buy you a round
or two. :-)

