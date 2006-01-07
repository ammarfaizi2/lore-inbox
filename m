Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWAGVYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWAGVYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbWAGVYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:24:55 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1977
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030584AbWAGVYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:24:54 -0500
Date: Sat, 07 Jan 2006 13:24:42 -0800 (PST)
Message-Id: <20060107.132442.80466568.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv6/: small cleanups
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060107181723.GP3774@stusta.de>
References: <20060107181723.GP3774@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 7 Jan 2006 19:17:23 +0100

> This patch contains the following cleanups:
> - addrconf.c: make addrconf_dad_stop() static
> - inet6_connection_sock.c should #include <net/inet6_connection_sock.h>
>   for getting the prototypes of it's global functions
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Also applied, thanks.
