Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTENUrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbTENUrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:47:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44702 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262771AbTENUrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:47:39 -0400
Date: Wed, 14 May 2003 14:00:07 -0700 (PDT)
Message-Id: <20030514.140007.15250832.davem@redhat.com>
To: kaber@trash.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix two bogus kfree(skb)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EC260D9.9050401@trash.net>
References: <3EC260D9.9050401@trash.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick McHardy <kaber@trash.net>
   Date: Wed, 14 May 2003 17:29:29 +0200

   This patch fixes two occurences of kfree(skb) in net/bridge/br_input.c and
   net/decnet/netfilter/dn_rtmsg.c.
   
Applied, thank you.
