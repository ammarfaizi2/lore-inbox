Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVKOFno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVKOFno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKOFno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:43:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38892
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751336AbVKOFnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:43:43 -0500
Date: Mon, 14 Nov 2005 21:43:49 -0800 (PST)
Message-Id: <20051114.214349.74490724.davem@davemloft.net>
To: lcapitulino@mandriva.com.br
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] - Fixes sparse warning in ipv6/ipv6_sockglue.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051114095422.5cc4727f.lcapitulino@mandriva.com.br>
References: <20051114095422.5cc4727f.lcapitulino@mandriva.com.br>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Date: Mon, 14 Nov 2005 09:54:22 -0200

> The patch below fixes the following sparse warning:
> 
> net/ipv6/ipv6_sockglue.c:291:13: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

Applied, thanks.
