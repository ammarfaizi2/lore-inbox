Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWH2G5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWH2G5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 02:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWH2G5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 02:57:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34973
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932106AbWH2G5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 02:57:13 -0400
Date: Mon, 28 Aug 2006 23:57:11 -0700 (PDT)
Message-Id: <20060828.235711.130237501.davem@davemloft.net>
To: bunk@stusta.de
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/atm/: proper prototypes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060820230006.GW7813@stusta.de>
References: <20060820230006.GW7813@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 21 Aug 2006 01:00:06 +0200

> This patch adds proper prototypes in net/atm/mpc.h for two global 
> functions in net/atm/mpoa_proc.c
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied to net-2.6.19, thanks Adrian.
