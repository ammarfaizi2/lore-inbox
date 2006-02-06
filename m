Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWBFDVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWBFDVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWBFDVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:21:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbWBFDVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:21:07 -0500
Date: Sun, 5 Feb 2006 19:20:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: jbowler@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx
 devices]
Message-Id: <20060205192025.4006a554.akpm@osdl.org>
In-Reply-To: <1139154997.14624.20.camel@localhost.localdomain>
References: <1139154997.14624.20.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> +MODULE_AUTHOR("John Bowler <jbowler@acm.org>");
> +MODULE_DESCRIPTION("IXP4XX GPIO LED driver");
> +MODULE_LICENSE("MIT");

MIT license is unusual.  There's one other file in the kernel which uses it
and that's down in MTD where nobody dares look.

I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.

