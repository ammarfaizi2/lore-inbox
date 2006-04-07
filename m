Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWDGFiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWDGFiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWDGFiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:38:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59618
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932273AbWDGFiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:38:04 -0400
Date: Thu, 06 Apr 2006 22:38:00 -0700 (PDT)
Message-Id: <20060406.223800.61034246.davem@davemloft.net>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kzalloc: use in alloc_netdev
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060407053204.11316.44763.stgit@zion.home.lan>
References: <20060407053204.11316.44763.stgit@zion.home.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Date: Fri, 07 Apr 2006 07:32:05 +0200

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Noticed this use, fixed it.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Applied, thanks.
