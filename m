Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTA2AmN>; Tue, 28 Jan 2003 19:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTA2AmN>; Tue, 28 Jan 2003 19:42:13 -0500
Received: from dp.samba.org ([66.70.73.150]:7322 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264644AbTA2AmN>;
	Tue, 28 Jan 2003 19:42:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       Herbert Xu <herbert@debian.org>
Subject: Re: [2.5] initrd/mkinitrd still not working 
In-reply-to: Your message of "Tue, 28 Jan 2003 12:10:49 CDT."
             <Pine.LNX.3.96.1030128120708.32466C-100000@gatekeeper.tmr.com> 
Date: Wed, 29 Jan 2003 11:48:17 +1100
Message-Id: <20030129005134.6E7E82C41B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1030128120708.32466C-100000@gatekeeper.tmr.com> you w
rite:
> beating around the bush: how about adding mkinitrd to the other module
> stuff before 0.9.9 is really released, using the same .old technique used
> for insmod et al? It would allow people doing testing of both 2.4 and 2.5
> kernels to stop fighting build issues.

Hmm, unlike modutils, I've never even used mkinitrd, let alone read
the code (mmm... shell... yum!).  For that reason alone I'm not the
guy to take it over (plus, I'm extremely lazy).

Herbert, I'd be happy to discuss any mkinitrd changes, or put a patch
into module-init-tools (or the FAQ?).

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
