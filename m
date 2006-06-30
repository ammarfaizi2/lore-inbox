Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932821AbWF3ADp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbWF3ADp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbWF3ADo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:03:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61103
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932821AbWF3ADm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:03:42 -0400
Date: Thu, 29 Jun 2006 17:03:40 -0700 (PDT)
Message-Id: <20060629.170340.55510056.davem@davemloft.net>
To: samuel@sortiz.org
Cc: bunk@stusta.de, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, reiga@dspnet.fr.eu.org,
       irda-users@lists.sourceforge.net
Subject: Re: [PATCH 2/2] [IrDA] Fix the AU1000 FIR dependencies
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060630065607.GB4729@sortiz.org>
References: <20060629154148.GA19712@stusta.de>
	<20060630065607.GB4729@sortiz.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Ortiz <samuel@sortiz.org>
Date: Fri, 30 Jun 2006 09:56:07 +0300

> AU1000 FIR is broken, it should depend on SOC_AU1000.
> 
> Spotted by Jean-Luc Leger.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Samuel Ortiz <samuel@sortiz.org>

Applied, thanks.
