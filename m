Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVGYCTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVGYCTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVGYCTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:19:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7880
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261596AbVGYCRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:17:42 -0400
Date: Sun, 24 Jul 2005 19:17:56 -0700 (PDT)
Message-Id: <20050724.191756.105797967.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050723091455.GA12015@2ka.mipt.ru>
References: <20050723125427.GA11177@rama>
	<20050723091455.GA12015@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Sat, 23 Jul 2005 13:14:55 +0400

> Andrew has no objection against connector and it lives in -mm

A patch sitting in -mm has zero significance.  A lot of junk
and useless things end up there as often Andrew incorporates
just about every single patch he sees posted to linux-kernel
unless he personally knows of some reason why the change might
be wrong.

So "it's in -mm" is not a metric to use.

> All objections against it was only type of - "I do not like it"
> Dmitry had some bugfixes which were added.

People like James Morris had very specific objections about it.

You are a control freak and in general very very difficult to work
with, so nobody wants to help you fix things up.
