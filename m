Return-Path: <linux-kernel-owner+w=401wt.eu-S1030181AbXAEBBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbXAEBBT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 20:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbXAEBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 20:01:19 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53209
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965134AbXAEBBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 20:01:18 -0500
Date: Thu, 04 Jan 2007 17:01:18 -0800 (PST)
Message-Id: <20070104.170118.129774527.davem@davemloft.net>
To: ahendry@tusc.com.au
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] X.25: Trivial, SOCK_DEBUG's in x25_facilities missing
 newlines
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167885564.5124.98.camel@localhost>
References: <1167885564.5124.98.camel@localhost>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: ahendry <ahendry@tusc.com.au>
Date: Thu, 04 Jan 2007 15:39:24 +1100

> Trivial. Newlines missing on the SOCK_DEBUG's for X.25 facility negotiation.
> 
> Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

Applied, thanks Andrew.
