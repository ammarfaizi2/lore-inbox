Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVIATpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVIATpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbVIATpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:45:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8935
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030324AbVIATpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:45:49 -0400
Date: Thu, 01 Sep 2005 12:45:52 -0700 (PDT)
Message-Id: <20050901.124552.132066739.davem@davemloft.net>
To: ecashin@coraid.com
Cc: linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87k6i0bnyn.fsf@coraid.com>
References: <87vf1mm7fk.fsf@coraid.com>
	<20050831.232430.50551657.davem@davemloft.net>
	<87k6i0bnyn.fsf@coraid.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 01 Sep 2005 15:13:52 -0400

> The aoe driver looks OK, but it turns out there's a byte swapping bug
> in the vblade that could be related if he's running the vblade on a
> big endian host (even though he said it was an x86 host), but I
> haven't heard back from the original poster yet.

I see, thanks for looking into this.
