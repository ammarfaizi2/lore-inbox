Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWHHXrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWHHXrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWHHXrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:47:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40894
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030341AbWHHXry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:47:54 -0400
Date: Tue, 08 Aug 2006 16:47:59 -0700 (PDT)
Message-Id: <20060808.164759.23717438.davem@davemloft.net>
To: pavlin@icir.org
Cc: linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: Bug in the RTM_SETLINK kernel API for setting MAC address 
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608081826.k78IQiZM084824@possum.icir.org>
References: <davem@davemloft.net>
	<200608081826.k78IQiZM084824@possum.icir.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavlin Radoslavov <pavlin@icir.org>
Date: Tue, 08 Aug 2006 11:26:44 -0700

> Can I presume that the fix will be in the next kernel release
> (2.6.17.8 or 2.6.18), so we will know to reverse our userland
> work-around changes when the kernel is out.

Yes, I will submit it for both 2.6.18 and 2.6.17.x-stable
