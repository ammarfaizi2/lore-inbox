Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUJRSmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUJRSmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUJRSjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:39:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:22144 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267353AbUJRSiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:38:08 -0400
Date: Mon, 18 Oct 2004 11:38:07 -0700
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Re: Enough with the ad-hoc naming schemes, please
Message-Id: <20041018113807.488969ab.cliffw@osdl.org>
In-Reply-To: <20041018180851.GA28904@waste.org>
References: <20041018180851.GA28904@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 13:08:51 -0500
Matt Mackall <mpm@selenic.com> wrote:

> Dear Linus,
> 
> I can't help but notice you've broken all the tools that rely on a
> stable naming scheme TWICE in the span of LESS THAN ONE POINT RELEASE.
> 
> In both cases, this could have been avoided by using Marcello's 2.4
> naming scheme. It's very simple: when you think something is "final",
> you call it a "release candidate" and tag it "-rcX". If it works out,
> you rename it _unmodified_ and everyone can trust that it hasn't
> broken again in the interval. If it's not "final" and you're accepting
> more than bugfixes, you call it a "pre-release" and tag it "-pre".
> Then developers and testers and automated tools all know what to
> expect.

Speaking for OSDL's automated testing team, we second this motion. 
judith
cliffw
OSDL


> 
> -- 
> Mathematics is the supreme nostalgia of our time.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
