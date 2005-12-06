Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVLFCRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVLFCRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVLFCRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:17:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26076
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964912AbVLFCRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:17:48 -0500
Date: Mon, 05 Dec 2005 18:17:32 -0800 (PST)
Message-Id: <20051205.181732.34234732.davem@davemloft.net>
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Tue, 6 Dec 2005 03:04:11 +0100 (CET)

> The dmesg entry comes from 2.6.15-rc2, but is kind of the same, expect not 
> all versions has the ugly and annoying face.

1) Lots of problems have been fixed that trigger that bug message,
   please give 2.6.15-rc5 a spin.

2) You didn't give what the failure mode is for kernels such
   as 2.6.14.2, which should work, and certainly don't print out
   that bug message

3) Finally, this discussion belongs on sparclinux@vger.kernel.org (CC'd),
   not linux-kernel.
