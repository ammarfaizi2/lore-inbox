Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUFIGwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUFIGwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 02:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUFIGwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 02:52:33 -0400
Received: from web52203.mail.yahoo.com ([206.190.39.85]:46984 "HELO
	web52203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265660AbUFIGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 02:52:23 -0400
Message-ID: <20040609065219.32565.qmail@web52203.mail.yahoo.com>
Date: Tue, 8 Jun 2004 23:52:19 -0700 (PDT)
From: linux lover <linux_lover2004@yahoo.com>
Subject: interpret following C statement?
To: linuxkernel <linux-kernel@vger.kernel.org>
Cc: linuxnet <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
how to interpret following C statement?
#define TCP_SKB_CB(__skb)       ((struct tcp_skb_cb 
*)&((__skb)->cb[0]))
what is use of tcp_skb_cb structure in kernel source
tcp.h? how 
TCP_SKB_CB(skb) is translated in its definition?
regards,
linux_lover






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
