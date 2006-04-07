Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWDGVy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWDGVy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWDGVy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:54:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16797
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964942AbWDGVy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:54:57 -0400
Date: Fri, 07 Apr 2006 14:53:40 -0700 (PDT)
Message-Id: <20060407.145340.44275423.davem@davemloft.net>
To: akpm@osdl.org
Cc: blaisorblade@yahoo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kzalloc: use in alloc_netdev
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060406225232.660e8251.akpm@osdl.org>
References: <20060407053204.11316.44763.stgit@zion.home.lan>
	<20060406225232.660e8251.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 6 Apr 2006 22:52:32 -0700

> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> >
> > Noticed this use, fixed it.
> 
> OK, but I think that if we're going to make conversions like this it's best
> to do it in decent-sized chunks, just to keep the patch volume down.

Applied, thanks.
