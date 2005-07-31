Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVGaAJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVGaAJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVGaAJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:09:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25989
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262907AbVGaAJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:09:16 -0400
Date: Sat, 30 Jul 2005 17:09:23 -0700 (PDT)
Message-Id: <20050730.170923.74721539.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050730210807.E26592@flint.arm.linux.org.uk>
References: <20050729161343.A18249@flint.arm.linux.org.uk>
	<20050730.124052.104057695.davem@davemloft.net>
	<20050730210807.E26592@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sat, 30 Jul 2005 21:08:07 +0100

> Thanks David.

No problem.  An interesting tidbit would be whether the
system is stable, without your patch you posted, in pure
uniprocessor mode with these cpus.
