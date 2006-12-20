Return-Path: <linux-kernel-owner+w=401wt.eu-S964853AbWLTDfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWLTDfV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWLTDfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:35:21 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37097
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964840AbWLTDfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:35:20 -0500
Date: Tue, 19 Dec 2006 19:35:18 -0800 (PST)
Message-Id: <20061219.193518.97293486.davem@davemloft.net>
To: bunk@stusta.de
Cc: chas@cmf.nrl.navy.mil, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/atm/Kconfig: remove dead ATM_TNETA1570
 option
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061219041300.GD6993@stusta.de>
References: <20061219041300.GD6993@stusta.de>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 19 Dec 2006 05:13:00 +0100

> This patch removes the unconverted ATM_TNETA1570 option that also lacks 
> any code in the kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
