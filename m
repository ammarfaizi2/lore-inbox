Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbUCLXUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbUCLXUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:20:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:44483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263025AbUCLXUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:20:08 -0500
Date: Fri, 12 Mar 2004 15:22:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-Id: <20040312152206.61604447.akpm@osdl.org>
In-Reply-To: <20040312204458.GJ20174@waste.org>
References: <20040312204458.GJ20174@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> 2.6.3 -> 2.6.4
> 
>    text	   data	    bss	    dec	    hex	filename
> 3313135	 660247	 162472	4135854	 3f1bae	vmlinux-2.6.3-c2.6.3
> 3342019	 664154	 162344	4168517	 3f9b45	vmlinux-2.6.4-c2.6.3
> 
> [ Results of size <a> <b>. -c2.6.3 means both kernel images were built
> with the 2.6.3 defconfig.

But defconfig was changed between 2.6.3 and 2.6.4.

