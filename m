Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVE0Uo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVE0Uo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVE0Uo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:44:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13770
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261704AbVE0UlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:41:19 -0400
Date: Fri, 27 May 2005 13:41:03 -0700 (PDT)
Message-Id: <20050527.134103.10293460.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: mchan@broadcom.com, linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <429785B5.6020705@pobox.com>
References: <20050527.123037.68041200.davem@davemloft.net>
	<1117221859.4310.6.camel@rh4>
	<429785B5.6020705@pobox.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Fri, 27 May 2005 16:40:21 -0400

> pci.ids is only used in one location -- deprecated /proc/pci -- and will 
> be removed in the next year or so, I imagine. Further, pci.ids is 
> periodically sync'd en masse from sourceforge into the kernel by janitors.

Good point.
