Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVIBU1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVIBU1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVIBU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:27:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48065
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751324AbVIBU1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:27:51 -0400
Date: Fri, 02 Sep 2005 13:27:54 -0700 (PDT)
Message-Id: <20050902.132754.118393946.davem@davemloft.net>
To: bunk@stusta.de
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] sparc: "extern inline" -> "static inline"
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050902202444.GS3657@stusta.de>
References: <20050902202444.GS3657@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 2 Sep 2005 22:24:44 +0200

> "extern inline" doesn't make much sense.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Patch does not apply to Linus's current tree, every change
in include/asm-sparc/spinlock.h was rejected.
