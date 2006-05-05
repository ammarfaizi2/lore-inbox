Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWEEXTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWEEXTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWEEXTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 19:19:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48545
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751220AbWEEXTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 19:19:06 -0400
Date: Fri, 05 May 2006 16:19:07 -0700 (PDT)
Message-Id: <20060505.161907.110814511.davem@davemloft.net>
To: mpm@selenic.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060505230324.GX15445@waste.org>
References: <8.420169009@selenic.com>
	<20060505.141040.53473194.davem@davemloft.net>
	<20060505230324.GX15445@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Fri, 5 May 2006 18:03:24 -0500

> And my claim is they don't actually have any entropy. If they want
> to continue fooling themselves, they can copy the device node for
> /dev/urandom to /dev/random.

Prove it and convince us.

The burdon of proof is on your shoulders, since you're the one
who wants to just rip it out without any satisfactory replacement.
