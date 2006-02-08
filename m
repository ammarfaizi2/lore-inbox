Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWBHGhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWBHGhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWBHGhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:37:00 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15837
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161003AbWBHGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:36:59 -0500
Date: Tue, 07 Feb 2006 22:36:47 -0800 (PST)
Message-Id: <20060207.223647.00551741.davem@davemloft.net>
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unify pfn_to_page take 2 [22/25] sparc64 funcs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43E9905E.7060609@jp.fujitsu.com>
References: <43E9905E.7060609@jp.fujitsu.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:31:58 +0900

> Select CONFIG_DONT_INLINE_PFN_TO_PAGE=y
> sparc64 can use generic funcs by defining ARCH_PFN_OFFSET as pfn_base.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitu.com>

This looks OK.
