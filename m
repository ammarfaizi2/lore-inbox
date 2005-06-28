Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVF1XCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVF1XCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVF1XA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:00:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41450
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261231AbVF1W76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:59:58 -0400
Date: Tue, 28 Jun 2005 15:59:01 -0700 (PDT)
Message-Id: <20050628.155901.78169707.davem@davemloft.net>
To: arnd@arndb.de
Cc: jgarzik@pobox.com, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       netdev@vger.kernel.org, utz.bacher@de.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com
Subject: Re: [PATCH] net: add missing include to netdevice.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200506281547.04620.arnd@arndb.de>
References: <200506281528.08834.arnd@arndb.de>
	<200506281547.04620.arnd@arndb.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 Jun 2005 15:47:03 +0200

> linux/etherdevice.h can't be included standalone at the moment, which
> is required in order to sort the header files in the recommended
> alphabetic order. This patch fixes that and is needed to build spider_net.
> 
> Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Applied, thanks a lot Arnd.
