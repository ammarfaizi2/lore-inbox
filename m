Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVG0WtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVG0WtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVG0UWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:22:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21144
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262497AbVG0UWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:22:17 -0400
Date: Wed, 27 Jul 2005 13:19:00 -0700 (PDT)
Message-Id: <20050727.131900.59654701.davem@davemloft.net>
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

> # HG changeset patch
> # User mpm@selenic.com
> # Node ID 6cdd6f36d53678a016cfbf5ce667cbd91504d538
> # Parent  75716ae25f9d87ee2a5ef7c4df2d8f86e0f3f762
> Move in_aton from net/ipv4/utils.c to net/core/utils.c

This patch doesn't apply, in the current 2.6.x GIT tree
NETCONSOLE does not depend on NETDEVICES.

Please fix up this patch so that I can apply it.
Thanks.
