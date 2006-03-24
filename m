Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423173AbWCXGNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423173AbWCXGNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423179AbWCXGMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45011
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423173AbWCXGMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:12:19 -0500
Date: Thu, 23 Mar 2006 22:08:57 -0800 (PST)
Message-Id: <20060323.220857.24982378.davem@davemloft.net>
To: kaber@trash.net
Cc: bunk@stusta.de, zhaojignmin@hotmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [2.6 patch] ip_conntrack_helper_h323.c: EXPORT_SYMBOL'ed
 functions shouldn't be static
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <44234B10.5040802@trash.net>
References: <20060324000801.GM22727@stusta.de>
	<20060323.161314.59991770.davem@davemloft.net>
	<44234B10.5040802@trash.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Fri, 24 Mar 2006 02:27:44 +0100

> I guess I should send it to lkml anyway. It boots fine, I couldn't
> figure out how to compare checksums, since the time of compilation
> and a couple other dynamically generated strings end up in the binary.

This looks fine, I'll push it in during my next round of networking
updates.
