Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWCYMGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWCYMGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCYMGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:06:51 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49555
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751384AbWCYMGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:06:50 -0500
Date: Sat, 25 Mar 2006 04:06:54 -0800 (PST)
Message-Id: <20060325.040654.133194625.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060325120546.GA6100@flint.arm.linux.org.uk>
References: <20060325.024226.53296559.davem@davemloft.net>
	<20060325034744.35b70f43.akpm@osdl.org>
	<20060325120546.GA6100@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sat, 25 Mar 2006 12:05:46 +0000

> So no, this doesn't work.  Isn't it about time the pre-CPU hotplug SMP
> stuff was updated, rather than trying to messily support two different
> SMP initialisation methodologies in generic code with band aid plasters
> all over?

Agreed.
