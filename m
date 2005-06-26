Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVFZWVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVFZWVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFZWVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:21:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34208
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261605AbVFZWVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:21:41 -0400
Date: Sun, 26 Jun 2005 15:21:30 -0700 (PDT)
Message-Id: <20050626.152130.45515497.davem@davemloft.net>
To: bunk@stusta.de
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let TCP_CONG_ADVANCED default to n
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050626160546.GJ3629@stusta.de>
References: <20050626160546.GJ3629@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 26 Jun 2005 18:05:46 +0200

> It doesn't seem to make much sense to let an "If unsure, say N." option 
> default to y.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Sorry, thinko on my part.

Patch applied, thanks Adrian.
