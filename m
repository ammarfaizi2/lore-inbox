Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbTF3FBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 01:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbTF3FBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 01:01:00 -0400
Received: from dp.samba.org ([66.70.73.150]:46793 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265737AbTF3FA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 01:00:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup 
In-reply-to: Your message of "Sat, 28 Jun 2003 01:33:58 +0200."
             <20030627233357.GN24661@fs.tum.de> 
Date: Mon, 30 Jun 2003 14:38:12 +1000
Message-Id: <20030630051516.AAEC12C220@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030627233357.GN24661@fs.tum.de> you write:
> - remove useless short descriptions above CONFIG_*

> -Connection tracking (required for masq/NAT)
>  CONFIG_IP_NF_CONNTRACK

Can you really do this?  A quick skim didn't find anyone else skipping
this line...

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
