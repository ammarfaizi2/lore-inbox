Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWJLVnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWJLVnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWJLVnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:43:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9454
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750730AbWJLVnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:43:13 -0400
Date: Thu, 12 Oct 2006 14:43:13 -0700 (PDT)
Message-Id: <20061012.144313.35470667.davem@davemloft.net>
To: shemminger@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH] rename net_random to random32
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061012102638.7381269a@freekitty>
References: <20061011122938.7e81f4bc@freekitty>
	<20061012000749.be62f2e0.akpm@osdl.org>
	<20061012102638.7381269a@freekitty>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 12 Oct 2006 10:26:38 -0700

> 
> Make net_random() more widely available by calling it random32
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Signed-off-by: David S. Miller <davem@davemloft.net>
