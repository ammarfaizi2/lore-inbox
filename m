Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWC3IHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWC3IHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWC3IHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:07:38 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1232
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751325AbWC3IHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:07:38 -0500
Date: Thu, 30 Mar 2006 00:08:02 -0800 (PST)
Message-Id: <20060330.000802.55613013.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] deinline 200+ byte inlines in sock.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603301026.24864.vda@ilport.com.ua>
References: <200603301026.24864.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Thu, 30 Mar 2006 10:26:24 +0300

> We have 200+ byte inlines in sock.h. That's way too large
> in my opinion.

In Linus's tree already.

Would you please check the relevant trees before re-posting patches?
Thanks a lot.
