Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUJ0CLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUJ0CLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUJ0CLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:11:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:26256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261574AbUJ0CLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:11:17 -0400
Date: Tue, 26 Oct 2004 19:08:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: riel@redhat.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-Id: <20041026190856.1472b58e.akpm@osdl.org>
In-Reply-To: <20041027013522.GR14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au>
	<Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com>
	<20041027005425.GO14325@dualathlon.random>
	<20041027005637.GP14325@dualathlon.random>
	<20041027013522.GR14325@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> this _incremental_ 2/? patch should fix the longtanding kswapd issue
>  vs protection algorithm

Could you please email the patch which this depends on?
