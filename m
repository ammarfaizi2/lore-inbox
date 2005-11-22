Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVKVXcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVKVXcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVKVXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:32:18 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1740
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030196AbVKVXcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:32:17 -0500
Date: Tue, 22 Nov 2005 15:32:16 -0800 (PST)
Message-Id: <20051122.153216.30197455.davem@davemloft.net>
To: bunk@stusta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/sbus/char/aurora.c: "extern inline" ->
 "static inline"
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051120232358.GJ16060@stusta.de>
References: <20051120232358.GJ16060@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 21 Nov 2005 00:23:58 +0100

> "extern inline" doesn't make much sense.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks a lot.
