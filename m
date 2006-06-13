Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWFMWXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWFMWXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWFMWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:23:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5598
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964778AbWFMWXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:23:45 -0400
Date: Tue, 13 Jun 2006 15:23:59 -0700 (PDT)
Message-Id: <20060613.152359.109570552.davem@davemloft.net>
To: chase.venters@clientec.com
Cc: jheffner@psc.edu, torvalds@osdl.org, lkml@rtr.ca,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0606131706040.4856@turbotaz.ourhouse>
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
	<448F03B3.5040501@psc.edu>
	<Pine.LNX.4.64.0606131706040.4856@turbotaz.ourhouse>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chase Venters <chase.venters@clientec.com>
Date: Tue, 13 Jun 2006 17:09:16 -0500 (CDT)

> Does anyone have any interesting statistics on how often end-users
> are likely to run into this crap?

I think it's much less likely than the ECN stuff, by a long shot.
