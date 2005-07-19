Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVGSVFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVGSVFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGSVFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:05:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37845
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261993AbVGSVEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:04:14 -0400
Date: Tue, 19 Jul 2005 14:01:04 -0700 (PDT)
Message-Id: <20050719.140104.68160812.davem@davemloft.net>
To: bunk@stusta.de
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050719182919.GA5531@stusta.de>
References: <20050719182919.GA5531@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 19 Jul 2005 20:29:19 +0200

> NETCONSOLE=y and INET=n results in the following compile error:

Also applied, thanks Adrian.
