Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWAFVUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWAFVUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWAFVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:20:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24505
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932523AbWAFVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:20:30 -0500
Date: Fri, 06 Jan 2006 13:15:36 -0800 (PST)
Message-Id: <20060106.131536.88566896.davem@davemloft.net>
To: joecool1029@gmail.com
Cc: bunk@stusta.de, wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix ipvs compilation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <d4757e600601052043u647658f1yaa15b0f396b4ad3c@mail.gmail.com>
References: <20060105135943.GA3831@stusta.de>
	<d4757e600601052043u647658f1yaa15b0f396b4ad3c@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe <joecool1029@gmail.com>
Date: Thu, 5 Jan 2006 23:43:52 -0500

> Thats not all either,  ./net/ipv4/netfilter/ipt_helper.c has the same
> error and the same fix.
> 
> Here's the patch for this one.  Sorry for the dupe.. i sent the last
> as html by accident.

Applied, please provide a "Signed-off-by:" line with your patch
next time.

Thanks.
