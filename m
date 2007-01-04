Return-Path: <linux-kernel-owner+w=401wt.eu-S932236AbXADCte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbXADCte (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 21:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbXADCtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 21:49:33 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53626
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932238AbXADCtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 21:49:32 -0500
Date: Wed, 03 Jan 2007 18:49:32 -0800 (PST)
Message-Id: <20070103.184932.56812245.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org,
       linux-x25@vger.kernel.org
Subject: Re: [2.6 patch] proper prototype for x25_init_timers()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070103230928.GP20714@stusta.de>
References: <20070103230928.GP20714@stusta.de>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 4 Jan 2007 00:09:28 +0100

> This patch adds a proper prototype for x25_init_timers() in 
> include/net/x25.h
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
