Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264896AbSKEESq>; Mon, 4 Nov 2002 23:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbSKEESq>; Mon, 4 Nov 2002 23:18:46 -0500
Received: from dp.samba.org ([66.70.73.150]:26333 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264896AbSKEESp>;
	Mon, 4 Nov 2002 23:18:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader against 2.5.46: 8/9 
In-reply-to: Your message of "Tue, 05 Nov 2002 01:08:48 -0300."
             <20021105010848.D1408@almesberger.net> 
Date: Tue, 05 Nov 2002 15:24:51 +1100
Message-Id: <20021105042521.42C5E2C310@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021105010848.D1408@almesberger.net> you write:
> Rusty Russell wrote:
> > (although note that this option is never prompted for).
> 
> Aha, learned something new about Kconfig. Subtle ! ;-)
> Well, I guess, some fine day, it will ...

Kconfig is way cool.  The transition to a CONFIG_OBSOLETE version
sometime soon (eg 2.7) is now trivial.

Rusty.
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

