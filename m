Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbVKIVGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbVKIVGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbVKIVGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:06:01 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24811
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030778AbVKIVGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:06:00 -0500
Date: Wed, 09 Nov 2005 13:05:58 -0800 (PST)
Message-Id: <20051109.130558.34471475.davem@davemloft.net>
To: peterc@gelato.unsw.edu.au
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix fallout from CONFIG_IPV6_PRIVACY
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17265.16378.77270.7493@berry.gelato.unsw.EDU.AU>
References: <17265.16378.77270.7493@berry.gelato.unsw.EDU.AU>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chubb <peterc@gelato.unsw.edu.au>
Date: Wed, 9 Nov 2005 11:16:58 +1100

> Trying to build today's 2.6.14+git snapshot gives undefined references
> to use_tempaddr
> 
> Looks like an ifdef got left out.
> 
> Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

Applied, thanks Peter.
