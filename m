Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVJJSQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVJJSQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJJSQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:16:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54458
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751140AbVJJSQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:16:11 -0400
Date: Mon, 10 Oct 2005 11:16:11 -0700 (PDT)
Message-Id: <20051010.111611.106200571.davem@davemloft.net>
To: seb@frankengul.org
Cc: debian-sparc@lists.debian.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: Sparc64 U60: no iptables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051010082507.GA5157@frankengul.org>
References: <4349614F.1010408@frankengul.org>
	<20051009.202646.70198053.davem@davemloft.net>
	<20051010082507.GA5157@frankengul.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: seb@frankengul.org
Date: Mon, 10 Oct 2005 10:25:07 +0200

> Indeed they are. Does the patch assume that cpus are numbered in a
> row ?

Yes, and that assumption is incorrect.

> Now, I reverted the patch for ip_tables.c, ip6_tables.c and ebtables.c.
> Everything is working ok (11h uptime).

Right.
