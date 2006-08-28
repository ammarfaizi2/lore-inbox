Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWH1IJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWH1IJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWH1IJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:09:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27583
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751416AbWH1IJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:09:46 -0400
Date: Mon, 28 Aug 2006 01:09:48 -0700 (PDT)
Message-Id: <20060828.010948.131918560.davem@davemloft.net>
To: ak@suse.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, jdike@addtoit.com,
       B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608281003.02757.ak@suse.de>
References: <200608280950.04441.ak@suse.de>
	<200608281001.39381.arnd@arndb.de>
	<200608281003.02757.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Mon, 28 Aug 2006 10:03:02 +0200

> Thanks for brining it to my attention. I indeed think think the
> patch was wrong.

I disagree, this stuff really doesn't have a strong argument
for existence.
