Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUCDU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUCDU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:59:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:64182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbUCDU7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:59:11 -0500
Date: Thu, 4 Mar 2004 12:58:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "kha0s" <kernel@digitalkhaos.net>
Cc: linux-kernel@vger.kernel.org, kjo <kernel-janitors@osdl.org>
Subject: Re: request_irq
Message-Id: <20040304125814.14ab3f24.rddunlap@osdl.org>
In-Reply-To: <005d01c40226$b3af4f00$0200a8c0@alphawolf>
References: <005d01c40226$b3af4f00$0200a8c0@alphawolf>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004 12:24:05 -0800 kha0s wrote:

| Since the janitors page is down, can anyone tell me if request_irq() return
| values still need to be audited?

Hi,

It's still on the current TODO list.  I can't swear whether it
should still be there or not, unfortunately.

BTW, while the kernelnewbies.org server is down, you can find
the kernel-janitors stuff at
  http://developer.osdl.org/rddunlap/kernel-janitors/

--
~Randy
