Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752071AbWHNXWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbWHNXWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWHNXWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:22:25 -0400
Received: from xenotime.net ([66.160.160.81]:22161 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752071AbWHNXWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:22:25 -0400
Date: Mon, 14 Aug 2006 16:25:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Vlasenko <vda.linux@googlemail.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] aic7xxx: remove excessive inlining
Message-Id: <20060814162516.1a458ff9.rdunlap@xenotime.net>
In-Reply-To: <20060814161434.d643f568.akpm@osdl.org>
References: <200608131457.21951.vda.linux@googlemail.com>
	<20060814161434.d643f568.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 16:14:34 -0700 Andrew Morton wrote:

> On Sun, 13 Aug 2006 14:57:21 +0200
> Denis Vlasenko <vda.linux@googlemail.com> wrote:
> 
> > This is a resend.
> 
> Please resend ;)
> 
> - All these patches had the same Subject:, thus forcing me to invent
>   titles for you.  
> 
> - The changelogs are weird - think what they'll look like once they
> hit the git tree.  Someone will need to clean those changelogs up,
> and I'd prefer that it not be me.
> 
> - Missing Signed-off-by:'s.
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt is here to
> help.

Don't *zip them.

---
~Randy
