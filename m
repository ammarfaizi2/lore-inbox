Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVFMVdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFMVdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFMVdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:33:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35211
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261392AbVFMVb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:31:26 -0400
Date: Mon, 13 Jun 2005 14:31:14 -0700 (PDT)
Message-Id: <20050613.143114.35469427.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, ross.biro@gmail.com,
       netdev@vger.kernel.org
Subject: Re: [PATCH] net: fix sparse warning (plain int as NULL)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <9a8748490506131421707008ed@mail.gmail.com>
References: <Pine.LNX.4.62.0506122358570.16521@dragon.hyggekrogen.localhost>
	<20050613.135950.48528369.davem@davemloft.net>
	<9a8748490506131421707008ed@mail.gmail.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Mon, 13 Jun 2005 23:21:56 +0200

> Since tcp_ack_saw_tstamp() in 2.6.12-rc6-git6 only takes two arguments
> this patch is only relevant for -mm.

Thanks for the clarification.
