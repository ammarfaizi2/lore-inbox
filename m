Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbTAKJyl>; Sat, 11 Jan 2003 04:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTAKJyl>; Sat, 11 Jan 2003 04:54:41 -0500
Received: from dp.samba.org ([66.70.73.150]:11138 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267173AbTAKJyk>;
	Sat, 11 Jan 2003 04:54:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module-init-tools-0.9.7, depmod and GPL-only symbols 
In-reply-to: Your message of "Fri, 10 Jan 2003 23:16:49 BST."
             <20030110221649.GA5371@vana> 
Date: Sat, 11 Jan 2003 18:38:36 +1100
Message-Id: <20030111100327.8CA5B2C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030110221649.GA5371@vana> you write:
> Hi Rusty,
>    I finally got 2.5.56 running with configuration I always used (== almost
> everything modular), and I found that module-init-tools-0.9.7 has small
> problem with GPL-only symbols: depmod ignores them :-(
> 
>    As I did not notice any newer version, please apply patch below if you
> did not do something simillar already.

Yep, included; my bad.  Also did the same thing for System.map
parsing.

I'll probably release a new version today.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
