Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWISNgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWISNgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWISNgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:36:18 -0400
Received: from mail.windriver.com ([147.11.1.11]:29394 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1751955AbWISNgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:36:17 -0400
Subject: Re: [PATCH] Add Broadcom PHY support
In-Reply-To: <450F7498.8090504@garzik.org>
To: Jeff Garzik <jeff@garzik.org>
Date: Tue, 19 Sep 2006 09:35:42 -0400 (EDT)
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: ELM [version ME+ 2.5 PLalpha5]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <E1GPflG-0000n7-2o@lucciola>
From: Amy Fong <amy.fong@windriver.com>
X-OriginalArrivalTime: 19 Sep 2006 13:35:42.0726 (UTC) FILETIME=[80DD5260:01C6DBF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Charset ISO-8859-1 unsupported, converting... ]
> Amy Fong wrote:
> > [PATCH] Add Broadcom PHY support
> > 
> > This patch adds a driver to support the bcm5421s and bcm5461s PHY
> > 
> > Kernel version:  linux-2.6.18-rc6
> > 
> > Signed-off-by: Amy Fong <amy.fong@windriver.com>
> 
> And... where are the users of this phy driver?
> 
> 	Jeff
> 

This phy driver is used by the WRS's sbc8560 (bcm5421s) and sbc843x (bcm5461s) via the gianfar driver.

Amy
