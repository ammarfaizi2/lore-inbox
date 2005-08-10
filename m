Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVHJDiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVHJDiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 23:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVHJDiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 23:38:21 -0400
Received: from xenotime.net ([66.160.160.81]:37074 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964937AbVHJDiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 23:38:21 -0400
Date: Tue, 9 Aug 2005 20:38:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the big Documentation/Changes change
Message-Id: <20050809203817.2225a33f.rdunlap@xenotime.net>
In-Reply-To: <20050810011740.GR4006@stusta.de>
References: <20050810011740.GR4006@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005 03:17:40 +0200 Adrian Bunk wrote:

> I edited Documentation/Changes:
> - remove obsolete information
> - point to feature-list-2.6.txt instead of providing similar information
> - removed the URLs of the software packages (people compiling their own
>   kernel usually know where to find the required software)

I always found those real handy.

Overall, I find this a good idea.

> The resulting file is pretty short.

>  Documentation/Changes |  376 +-----------------------------------------
>  1 files changed, 15 insertions(+), 361 deletions(-)
> 
> --- linux-2.6.13-rc5-mm1-full/Documentation/Changes.old	2005-08-10 03:01:11.000000000 +0200
> +++ linux-2.6.13-rc5-mm1-full/Documentation/Changes	2005-08-10 03:12:12.000000000 +0200
> @@ -1,435 +1,89 @@

> -Kernel compilation
> -==================
> +Notes
> +=====
> +
> +Please read feature-list-2.6.txt for information about new features

We usually prefix Doc file names with Documentation/, even though
this is in the same directory.

but where is this file?  I can't find it.
Ah, it's in -mm only.

> +and changes compared to 2.4 kernels.

---
~Randy
