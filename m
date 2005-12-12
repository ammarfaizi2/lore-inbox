Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLLW0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLLW0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLLW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:26:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52374
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932121AbVLLW0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:26:23 -0500
Date: Mon, 12 Dec 2005 14:26:54 -0800 (PST)
Message-Id: <20051212.142654.62759069.davem@davemloft.net>
To: trizt@iname.com
Cc: mark@mtfhpc.demon.co.uk, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512121127240.12856@lai.local.lan>
References: <DGEKIABPPPEBAOMKAJCEKEAKCBAA.mark@mtfhpc.demon.co.uk>
	<Pine.LNX.4.64.0512121127240.12856@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Mon, 12 Dec 2005 11:38:32 +0100 (CET)

> I have been using gcc-3.3.5 (64bits) when building the kernel, today
> I did upgrade to gcc-3.3.6 (64bits), but still have the same problem
> with the X11.  For build normal system applications and tools I have
> gcc-3.3.6 (32bit).

I use gcc-4.0.2 and gcc-3.4.5 for all of my kernel builds.
