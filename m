Return-Path: <linux-kernel-owner+w=401wt.eu-S1752326AbXABXZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbXABXZM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbXABXZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:25:11 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36737
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752326AbXABXZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:25:10 -0500
Date: Tue, 02 Jan 2007 15:25:09 -0800 (PST)
Message-Id: <20070102.152509.48799363.davem@davemloft.net>
To: m.kozlowski@tuxland.pl
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: af_netlink module_put cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <200701021347.37952.m.kozlowski@tuxland.pl>
References: <200701021347.37952.m.kozlowski@tuxland.pl>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Tue, 2 Jan 2007 13:47:37 +0100

> Hello,
> 
> 	This patch removes redundant argument check for module_put().
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Applied, thanks.
