Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422844AbWJLIwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbWJLIwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbWJLIwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:52:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59328
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422844AbWJLIwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:52:14 -0400
Date: Thu, 12 Oct 2006 01:52:13 -0700 (PDT)
Message-Id: <20061012.015213.45515142.davem@davemloft.net>
To: akinobu.mita@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sch_htb: use rb_first() cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061012053024.GC29465@localhost>
References: <20061012053024.GC29465@localhost>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 12 Oct 2006 14:30:24 +0900

> Use rb_first() to get first entry in rb tree.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

Applied, thanks a lot.
