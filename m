Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWGRUxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWGRUxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGRUxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:53:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15263
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932400AbWGRUxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:53:45 -0400
Date: Tue, 18 Jul 2006 13:54:08 -0700 (PDT)
Message-Id: <20060718.135408.118623727.davem@davemloft.net>
To: henne@nachtwindheim.de
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Remove pci_module_init() from Intel I/OAT DMA engine
From: David Miller <davem@davemloft.net>
In-Reply-To: <44BD26E2.9080106@nachtwindheim.de>
References: <44BD26E2.9080106@nachtwindheim.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henne <henne@nachtwindheim.de>
Date: Tue, 18 Jul 2006 20:22:26 +0200

> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Changes pci_module_init() to pci_register_driver().
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Your email client corrupted your patch by changing tabs
into spaces, therefore your patch does not apply and is
unusable.
