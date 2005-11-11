Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVKKT5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVKKT5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVKKT5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:57:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4254
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750746AbVKKT5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:57:34 -0500
Date: Fri, 11 Nov 2005 11:57:33 -0800 (PST)
Message-Id: <20051111.115733.68226869.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: akpm@osdl.org, torvalds@osdl.org, shemminger@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] TCP build fix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051111094347.GA10876@havoc.gtf.org>
References: <20051111094347.GA10876@havoc.gtf.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Fri, 11 Nov 2005 04:43:47 -0500

> Recent TCP changes broke the build.
> 
> Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

Thanks for catching this Jeff.
