Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFBURY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFBURY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFBUL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:11:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37081
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261318AbVFBUE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:04:26 -0400
Date: Thu, 02 Jun 2005 13:04:18 -0700 (PDT)
Message-Id: <20050602.130418.52130198.davem@davemloft.net>
To: chas@cmf.nrl.navy.mil
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, juhl-lkml@dif.dk
Subject: Re: [PATCH] atm: kill pointless NULL checks and casts before
 kfree() [take two] 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200505182152.j4ILqb5M001881@ginger.cmf.nrl.navy.mil>
References: <Pine.LNX.4.62.0505102159270.2386@dragon.hyggekrogen.localhost>
	<200505182152.j4ILqb5M001881@ginger.cmf.nrl.navy.mil>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
Date: Wed, 18 May 2005 17:52:38 -0400

> [ATM]: [drivers] kill pointless NULL checks and casts before kfree()
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> Signed-off-by: Chas Williams <chas@cmf.nrl.navy.mil>

Applied, thanks Chas.
