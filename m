Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWC3H0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWC3H0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWC3H03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:26:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21203
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751230AbWC3H03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:26:29 -0500
Date: Wed, 29 Mar 2006 23:26:52 -0800 (PST)
Message-Id: <20060329.232652.113578226.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] deinline some larger functions from netdevice.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603301021.48925.vda@ilport.com.ua>
References: <200603301021.48925.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Thu, 30 Mar 2006 10:21:48 +0300

> Network folks did non comment on these two patches, let me try
> submitting them to you instead.

It's in my tree if you would bother checking:

	kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6.git
