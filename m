Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUHWBck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUHWBck (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 21:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUHWBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 21:32:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:37275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265264AbUHWBcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 21:32:39 -0400
Date: Sun, 22 Aug 2004 18:30:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockmeter for x86_64
Message-Id: <20040822183053.06628fb2.akpm@osdl.org>
In-Reply-To: <1093183598.806.9.camel@boxen>
References: <1093183598.806.9.camel@boxen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> This is basically a cut and paste from i386 code.
>  At some places however some unresolved addresses at places
>  like [0x1000211eb38] shows up, which is a bit weird. I'm hoping
>  for a comment from any of the SGI guys, as the code is so similar
>  to i386 I don't know if problem lies below or in the generic code.
> 
>  Against 2.6.8.1-mm2, but should apply against just about any -mm

Thanks - I'll add it to -mm.

If you want the SGI developers to pay attention to it, you'd better Cc
them.  One never knows how closely individuals monitor this list.

