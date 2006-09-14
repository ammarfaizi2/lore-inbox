Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWINDfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWINDfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWINDff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:35:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14033
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751257AbWINDff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:35:35 -0400
Date: Wed, 13 Sep 2006 20:36:26 -0700 (PDT)
Message-Id: <20060913.203626.104044096.davem@davemloft.net>
To: kaber@trash.net
Cc: bugfixer@list.ru, linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev@vger.kernel.org
Subject: Re: netdevice name corruption is still present in 2.6.18-rc6-mm1
From: David Miller <davem@davemloft.net>
In-Reply-To: <4503DD7B.1070003@trash.net>
References: <20060909032939.GA3087@nickolas.homeunix.com>
	<20060910020707.GA3160@nickolas.homeunix.com>
	<4503DD7B.1070003@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Sun, 10 Sep 2006 11:40:11 +0200

> Dave, please apply the attached patch to net-2.6.19, it fixes the
> netdevice name corruption reported by multiple people.

Applied, thanks a lot.
