Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVIDIYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVIDIYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVIDIYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:24:04 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:55717 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1750816AbVIDIYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:24:03 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: laplam@rpi.edu (Matt LaPlante)
Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200509032053.j83KrE1u028307@ms-smtp-04-eri0.southeast.rr.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EBpnC-0001SQ-00@gondolin.me.apana.org.au>
Date: Sun, 04 Sep 2005 18:23:58 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt LaPlante <laplam@rpi.edu> wrote:
>
> network connectivity on my router.  Upon further inspection I noticed the
> packet had actually caused a kernel panic (visible only on the monitor, now
> also unresponsive).

Thanks for the report.  I'll try to track it down.

If you could jot down the important bits of the panic message
(IP, Call-Trace) it would help me find the problem much quicker.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
