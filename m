Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWHHDvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWHHDvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHHDvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:51:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44736
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932473AbWHHDvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:51:09 -0400
Date: Mon, 07 Aug 2006 20:51:10 -0700 (PDT)
Message-Id: <20060807.205110.99456828.davem@davemloft.net>
To: cltien@gmail.com
Cc: w@1wt.eu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]pktgen oops when used with balance-tlb bonding
From: David Miller <davem@davemloft.net>
In-Reply-To: <cc862f80608071207q4a0b9662qad49b30096d00187@mail.gmail.com>
References: <20060802203854.GA462@1wt.eu>
	<cc862f80608071204y5b7b55a9n618dde95eb0c5b4@mail.gmail.com>
	<cc862f80608071207q4a0b9662qad49b30096d00187@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tien ChenLi" <cltien@gmail.com>
Date: Mon, 7 Aug 2006 15:07:06 -0400

> I forgot that if I also need to patch the fill_packet_ipv6 since I
> don't have experience with it. I guess we should patch that one too.

I'll fix that part up, thanks for mentioning this problem.
