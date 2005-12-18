Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbVLRXK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbVLRXK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVLRXK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 18:10:28 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39910
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965291AbVLRXK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 18:10:27 -0500
Date: Sun, 18 Dec 2005 15:10:07 -0800 (PST)
Message-Id: <20051218.151007.45256983.davem@davemloft.net>
To: trizt@iname.com
Cc: mark@mtfhpc.demon.co.uk, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512182257520.11208@lai.local.lan>
References: <Pine.LNX.4.64.0512121127240.12856@lai.local.lan>
	<20051212.142654.62759069.davem@davemloft.net>
	<Pine.LNX.4.64.0512182257520.11208@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Sun, 18 Dec 2005 23:03:37 +0100 (CET)

> I have tried gcc-3.4.5, but still I have a process that can lock the 
> console totally if you run something that looks into the /proc specially 
> the process after X itself (that one can't be kill). So I wonder if you do 
> use some patches for gcc or do you use the "vanilla" gcc?

I use whatever ships with Debian.
