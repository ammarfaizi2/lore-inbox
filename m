Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVLFKUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVLFKUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVLFKUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:20:45 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65249
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932489AbVLFKUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:20:44 -0500
Date: Tue, 06 Dec 2005 02:20:21 -0800 (PST)
Message-Id: <20051206.022021.46863653.davem@davemloft.net>
To: kjak@users.sourceforge.net, kjak@ispwest.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Socket filter instruction limit validation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <e16bc6209efd4b6e840f78f35de61b2f.kjak@ispwest.com>
References: <e16bc6209efd4b6e840f78f35de61b2f.kjak@ispwest.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kris Katterjohn" <kjak@ispwest.com>
Date: Tue, 6 Dec 2005 02:10:49 -0800

> This patch checks to make sure that the number of instructions doesn't surpass
> BPF_MAXINSNS in sk_chk_filter().
> 
> Signed-off-by: Kris Katterjohn <kjak@users.sourceforge.net>

How about posting networking patches to netdev@vger.kernel.org for
discussion, and the CC:'ing the networking maintainer (me)?

Thanks.
