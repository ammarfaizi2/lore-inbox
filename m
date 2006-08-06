Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWHFXg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWHFXg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHFXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:36:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8643
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750766AbWHFXgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:36:55 -0400
Date: Sun, 06 Aug 2006 16:37:10 -0700 (PDT)
Message-Id: <20060806.163710.13747870.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608062109.k76L9c1T017778@harpo.it.uu.se>
References: <200608062109.k76L9c1T017778@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 6 Aug 2006 23:09:38 +0200 (MEST)

> Correction, it turns out that all my 2.6 sparc64 kernels have
> had CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE enabled.

Ok, thanks for the info.

I'm still a bit stumped about this bug and trying to figure out what's
wrong.  I'll let you know when I have a patch to test.

