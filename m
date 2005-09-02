Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVIBTUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVIBTUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVIBTUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:20:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47570
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750860AbVIBTUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:20:16 -0400
Date: Fri, 02 Sep 2005 12:20:25 -0700 (PDT)
Message-Id: <20050902.122025.26971814.davem@davemloft.net>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more of sparc32 dependencies fallout
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050902191201.GB5155@ZenIV.linux.org.uk>
References: <20050902191201.GB5155@ZenIV.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: viro@ZenIV.linux.org.uk
Date: Fri, 2 Sep 2005 20:12:01 +0100

> More stuff that got exposed to sparc32 build due to inclusion of
> drivers/char/Kconfig in arch/sparc/Kconfig needs to be excluded.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, thanks Al.
