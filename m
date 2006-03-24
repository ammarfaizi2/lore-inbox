Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWCXH7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWCXH7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWCXH7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:59:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37513
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422774AbWCXH7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:59:36 -0500
Date: Thu, 23 Mar 2006 23:55:57 -0800 (PST)
Message-Id: <20060323.235557.88280922.davem@davemloft.net>
To: bunk@stusta.de
Cc: zhaojingmin@hotmail.com, zhaojignmin@hotmail.com, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 patch] ip_conntrack_helper_h323.c: make
 get_h245_addr()static
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060324075511.GV22727@stusta.de>
References: <20060324000916.GN22727@stusta.de>
	<BAY109-DAV122F44146DB217251703AEB3DF0@phx.gbl>
	<20060324075511.GV22727@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 24 Mar 2006 08:55:11 +0100

> The point is:
> There have been many occasions where people have said "I will need this 
> soon" in many different places in the kernel, and one year later it was 
> still unused.
> 
> If it will be needed at some point in the future, reverting my patch
> will be trivial.

Agreed.
