Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965405AbWIRFeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405AbWIRFeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965404AbWIRFeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:34:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19087
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965401AbWIRFeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:34:18 -0400
Date: Sun, 17 Sep 2006 22:35:12 -0700 (PDT)
Message-Id: <20060917.223512.25476592.davem@davemloft.net>
To: DJurzitza@harmanbecker.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, w@1wt.eu
Subject: Re: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols
 from /boot/System.map
From: David Miller <davem@davemloft.net>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
References: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 18 Sep 2006 07:23:58 +0200

> The 2.4 kernel series uses sys32_get_kernel_syms(struct kernel_sym32
> *table) for reading the kernel symbols (on sparc64). The size of
> struct kernel_sym is 64 byte on "normal" arches, but 72 byte on
> sparc64.

Jurzita, you do not need to post this patch multiple times.
I was simply on vacation for 2 weeks right after your first
posting so I had no chance to review the patch.
