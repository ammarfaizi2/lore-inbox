Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWHHDtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWHHDtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWHHDtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:49:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43712
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932400AbWHHDtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:49:22 -0400
Date: Mon, 07 Aug 2006 20:49:25 -0700 (PDT)
Message-Id: <20060807.204925.77405248.davem@davemloft.net>
To: cltien@gmail.com
Cc: w@1wt.eu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]pktgen oops when used with balance-tlb bonding
From: David Miller <davem@davemloft.net>
In-Reply-To: <cc862f80608071204y5b7b55a9n618dde95eb0c5b4@mail.gmail.com>
References: <cc862f80607221611x52efac88u620516e17edfa03b@mail.gmail.com>
	<20060802203854.GA462@1wt.eu>
	<cc862f80608071204y5b7b55a9n618dde95eb0c5b4@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tien ChenLi" <cltien@gmail.com>
Date: Mon, 7 Aug 2006 15:04:34 -0400

> Indeed the skb->mac.raw is already set just several lines up. Now only
> two lines are needed:
> 
> Signed-off-by: Chen-Li Tien <cltien@gmail.com>

Applied, thanks a lot.
