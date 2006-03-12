Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWCLIyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWCLIyI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 03:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWCLIyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 03:54:08 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49292
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751078AbWCLIyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 03:54:06 -0500
Date: Sun, 12 Mar 2006 00:54:19 -0800 (PST)
Message-Id: <20060312.005419.79564291.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: + git-net-arm-build-fix.patch added to -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603120838.k2C8cE31029994@shell0.pdx.osdl.net>
References: <200603120838.k2C8cE31029994@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Sun, 12 Mar 2006 00:36:01 -0800

> From: Andrew Morton <akpm@osdl.org>
> 
> net/core/sock.c: In function `sock_setsockopt':
> net/core/sock.c:460: error: duplicate case value
> net/core/sock.c:278: error: previously used here
> 
> Guess:

My bad, applied.

Thanks.
