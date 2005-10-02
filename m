Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVJBB0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVJBB0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 21:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVJBB0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 21:26:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23979
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750936AbVJBB0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 21:26:24 -0400
Date: Sat, 01 Oct 2005 18:26:20 -0700 (PDT)
Message-Id: <20051001.182620.32883151.davem@davemloft.net>
To: bunk@stusta.de
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] sparc: "extern inline" -> "static inline"
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051001230628.GF4212@stusta.de>
References: <20050902202444.GS3657@stusta.de>
	<20050902.132754.118393946.davem@davemloft.net>
	<20051001230628.GF4212@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 2 Oct 2005 01:06:28 +0200

> I just tried 2.6.14-rc3 and 2.6.14-rc2-mm2, and it applied against both.

'patch' and friends are much more lenient about white space
and other types of "fuzz" than the git patch application code
is.  So that can often be the reason.

But this version applies properly, thanks a lot Adrian.
