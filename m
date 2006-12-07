Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163869AbWLGXKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163869AbWLGXKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163862AbWLGXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:10:23 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33074
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1164090AbWLGXKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:10:18 -0500
Date: Thu, 07 Dec 2006 15:10:23 -0800 (PST)
Message-Id: <20061207.151023.63737373.davem@davemloft.net>
To: mchan@broadcom.com
Cc: bunk@stusta.de, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/bnx2.c: add an error check
From: David Miller <davem@davemloft.net>
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FD91@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <20061207113433.GC8963@stusta.de>
	<1551EAE59135BE47B544934E30FC4FC093FD91@NT-IRVA-0751.brcm.ad.broadcom.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Thu, 7 Dec 2006 09:31:40 -0800

> 
> Adrian Bunk wrote:
> > This patch adds a missing error check spotted by the Coverity checker.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> Acked-by: Michael Chan <mchan@broadcom.com>

Applied, thanks everyone.
