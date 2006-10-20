Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992522AbWJTG6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992522AbWJTG6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992526AbWJTG6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:58:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44182
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992522AbWJTG6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:58:33 -0400
Date: Thu, 19 Oct 2006 23:58:35 -0700 (PDT)
Message-Id: <20061019.235835.03111579.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] netpoll: initialize skb for UDP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061019171814.026676621@osdl.org>
References: <20061019171541.062261760@osdl.org>
	<20061019171814.026676621@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 19 Oct 2006 10:15:42 -0700

> Need to fully initialize skb to keep lower layers and queueing happy.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks Stephen.
