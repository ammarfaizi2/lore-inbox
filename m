Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUE1UKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUE1UKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUE1UKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:10:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:37550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263843AbUE1UKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:10:46 -0400
Date: Fri, 28 May 2004 13:00:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Proposal] DEBUG_SLAB should select DEBUG_SPINLOCK
Message-Id: <20040528130003.69a1e7c9.rddunlap@osdl.org>
In-Reply-To: <52zn7s5nus.fsf@topspin.com>
References: <528yfc72u8.fsf@topspin.com>
	<20040528124228.105ebcbb.rddunlap@osdl.org>
	<52zn7s5nus.fsf@topspin.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 2004 12:54:35 -0700 Roland Dreier wrote:

|     Randy> Andrew asked me to delay it until 2.6.6, which I did.  Sent
|     Randy> that, but not merged.
| 
|     Randy> I will be rediffing it and resending it again for 2.6.7 and
|     Randy> probably some intermediate kernels if that's what it takes.
| 
| Thanks for the info.  I guess I'll wait for your patch to be merged
| and then send my (trivial) patch.

You can wait, or send it to Andrew for merging (it will just be one
more small change for me), or send it to me for Kconfig.debug.

I won't lose it, but it's probably safer just to send it to Andrew,
and I can deal with that small diff later.

--
~Randy
