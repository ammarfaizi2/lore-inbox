Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWHRWmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWHRWmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWHRWmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:42:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751556AbWHRWmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:42:08 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [10/13]: module parameter for device
	timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <a47db3897e5de69fbe6bfaf1fea169a2@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <a47db3897e5de69fbe6bfaf1fea169a2@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Aug 2006 00:03:07 +0100
Message-Id: <1155942187.31543.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> The aoe_deadsecs module parameter sets the number of seconds that
> elapse before a nonresponsive AoE device is marked as dead.
> 

Isn't this a) per link dependant and b) needing to be runtime tuned
(sysfs say ?)

