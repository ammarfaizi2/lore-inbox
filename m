Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVHKT1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVHKT1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVHKT1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:27:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21154
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932315AbVHKT1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:27:46 -0400
Date: Thu, 11 Aug 2005 12:27:40 -0700 (PDT)
Message-Id: <20050811.122740.02298656.davem@davemloft.net>
To: master@sectorb.msk.ru
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5 panic with tg3, e1000, vlan, tso
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050811114835.GB3543@tentacle.sectorb.msk.ru>
References: <20050811114835.GB3543@tentacle.sectorb.msk.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Date: Thu, 11 Aug 2005 15:48:36 +0400

> Today my gateway crashed.

Known problem, please try Linus's current tree as we've
made a bug fix since -rc5 that we think fixes this bug.
