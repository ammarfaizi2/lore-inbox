Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTDJXbu (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTDJXbt (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:31:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53963 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264256AbTDJXbB (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:31:01 -0400
Date: Thu, 10 Apr 2003 16:36:36 -0700 (PDT)
Message-Id: <20030410.163636.62240589.davem@redhat.com>
To: gandalf@wlug.westbo.se, gandalf@netfilter.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix modify-after-free bug in ip_conntrack
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1050017895.11156.95.camel@tux.rsn.bth.se>
References: <1050017895.11156.95.camel@tux.rsn.bth.se>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Josefsson <gandalf@netfilter.org>
   Date: 11 Apr 2003 01:38:15 +0200
   
   Please apply to both 2.4 and 2.5

Applied, thanks.

You might try pinging Rusty, he's been reasonably responsive laterly.
In fact he's working on pushing the skb_linearize() bits deeper into
the netfilter stack.
