Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWGSAcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWGSAcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWGSAcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:32:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65201
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932440AbWGSAcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:32:17 -0400
Date: Tue, 18 Jul 2006 17:32:38 -0700 (PDT)
Message-Id: <20060718.173238.63509821.davem@davemloft.net>
To: jirislaby@gmail.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] NET: sun happymeal, little pci cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060718235638.DF54BAE43C5@sunset.davemloft.net>
References: <20060718235638.DF54BAE43C5@sunset.davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jirislaby@gmail.com>
Date: Tue, 18 Jul 2006 16:56:38 -0700 (PDT)

> NET: sun happymeal, little pci cleanup
> 
> Use pci_register_driver instead of pci_module_init. Use PCI_DEVICE macro.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Applied, thanks Jiri.
