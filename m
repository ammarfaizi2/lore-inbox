Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDAXYE>; Sun, 1 Apr 2001 19:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDAXXy>; Sun, 1 Apr 2001 19:23:54 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:39976 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132582AbRDAXXq>; Sun, 1 Apr 2001 19:23:46 -0400
Date: Sun, 1 Apr 2001 18:21:29 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: David Lang <dlang@diginsite.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.33.0104011559590.25794-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, David Lang wrote:
> if we want to get the .config as part of the report then we need to make
> it part of the kernel in some standard way (the old /proc/config flamewar)
> it's difficult enough sometimes for the sysadmin of a box to know what
> kernel is running on it, let alone a bug reporting script.

Let's hope it's not a flamewar, but here goes :)

We -need- .config, but /proc/config seems like pure bloat.

If a sysadmin (note I don't say "user") has no clue what his kernel
config is, or has no clue what kernel is running on his box, then
they should be fired before the day is out.

	Jeff



