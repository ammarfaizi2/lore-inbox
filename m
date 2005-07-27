Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVG0CxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVG0CxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 22:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVG0CxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 22:53:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5594
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261979AbVG0CxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 22:53:04 -0400
Date: Tue, 26 Jul 2005 19:53:20 -0700 (PDT)
Message-Id: <20050726.195320.89085462.davem@davemloft.net>
To: mpm@selenic.com
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050727023636.GP12006@waste.org>
References: <20050726235824.GN12006@waste.org>
	<20050726.170349.10935659.davem@davemloft.net>
	<20050727023636.GP12006@waste.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Tue, 26 Jul 2005 19:36:37 -0700

> [sch added to cc: as I think he's the effective pktgen maintainer]

No, that would be Robert Olsson.

> Move in_aton from net/ipv4/utils.c to net/core/utils.c

Fair enough.
