Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVKRRFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVKRRFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVKRRFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:05:49 -0500
Received: from [139.30.44.16] ([139.30.44.16]:31324 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S964829AbVKRRFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:05:48 -0500
Date: Fri, 18 Nov 2005 18:04:46 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Adrian Bunk <bunk@stusta.de>
cc: saw@saw.sw.com.sg, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
In-Reply-To: <20051118033302.GO11494@stusta.de>
Message-ID: <Pine.LNX.4.63.0511181758270.17047@gockel.physik3.uni-rostock.de>
References: <20051118033302.GO11494@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Adrian Bunk wrote:

> This patch removes the obsolete drivers/net/eepro100.c driver.
> 
> Is there any reason why it should be kept?
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Can you state a reason why it is obsolete and should be removed?
IMHO this would provide a much better commit message.

Tim
