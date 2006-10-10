Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWJJVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWJJVsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbWJJVsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49035
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030522AbWJJVrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:55 -0400
Date: Tue, 10 Oct 2006 14:47:53 -0700 (PDT)
Message-Id: <20061010.144753.57160083.davem@davemloft.net>
To: joro-lkml@zlug.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061010153745.GA27455@zlug.org>
References: <20061010153745.GA27455@zlug.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <joro-lkml@zlug.org>
Date: Tue, 10 Oct 2006 17:37:45 +0200

> This patch removes the driver of the IPv6-in-IPv4 tunnel driver (sit)
> from the IPv6 module. It adds an option to Kconfig which makes it
> possible to compile it as a seperate module.
> 
> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

Applied, thanks.
