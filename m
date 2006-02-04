Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWBDXwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWBDXwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWBDXwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:52:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12969
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932591AbWBDXvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:51:55 -0500
Date: Sat, 04 Feb 2006 15:51:45 -0800 (PST)
Message-Id: <20060204.155145.127399521.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, robert.olsson@its.uu.se, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [-mm patch] net/ipv4/fib_rules.c: make struct fib_rules static
 again
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060203210248.GK4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
	<20060203210248.GK4408@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 3 Feb 2006 22:02:48 +0100

> struct fib_rules became global for no good reason.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
