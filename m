Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWAJVPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWAJVPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWAJVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:15:42 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42137
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932254AbWAJVPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:15:40 -0500
Date: Tue, 10 Jan 2006 13:11:55 -0800 (PST)
Message-Id: <20060110.131155.67446881.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       reiga@dspnet.fr.eu.org
Subject: Re: [2.6 patch] drivers/net/irda/Kconfig: DONGLE_OLD: remove
 dependency on non-existing symbol
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060110170903.GQ3911@stusta.de>
References: <20060110170903.GQ3911@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 10 Jan 2006 18:09:03 +0100

> Jean-Luc Leger <reiga@dspnet.fr.eu.org> reported this alternative 
> dependency on a non-existing symbol.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.
