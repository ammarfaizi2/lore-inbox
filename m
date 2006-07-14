Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWGNVbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWGNVbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 17:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbWGNVbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 17:31:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62878
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161303AbWGNVbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 17:31:33 -0400
Date: Fri, 14 Jul 2006 14:31:40 -0700 (PDT)
Message-Id: <20060714.143140.35508183.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2: drivers/char/*synclink* compile errors
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060714184825.GB3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<20060714184825.GB3633@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 14 Jul 2006 20:48:25 +0200

> Krzysztof, the following compile errors are caused by your commit 
> c2ce920468624d87ec5f91f080ea99681dae6d88 in Linus' tree:

Yes, we let Krzysztof know about this yesterday.

If we don't get a fix over the weekend I will simply
revert the changeset.

Thanks Adrian.
