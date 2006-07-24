Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWGXGfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWGXGfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 02:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWGXGfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 02:35:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22932
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751411AbWGXGfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 02:35:44 -0400
Date: Sun, 23 Jul 2006 23:35:51 -0700 (PDT)
Message-Id: <20060723.233551.118951812.davem@davemloft.net>
To: cltien@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]pktgen oops when used with balance-tlb bonding
From: David Miller <davem@davemloft.net>
In-Reply-To: <cc862f80607221611x52efac88u620516e17edfa03b@mail.gmail.com>
References: <cc862f80607221611x52efac88u620516e17edfa03b@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tien ChenLi" <cltien@gmail.com>
Date: Sat, 22 Jul 2006 19:11:21 -0400

> I fixed a bug in pktgen so it won't cause oops when used with
> balance-tlb or balance-alb bonding driver:

Your email client corrupted the patch, turning tabs into space
characters, which makes the patch unusable.

You also did not supply a proper "Signed-off-by:" line for your
change.
