Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265860AbUBCKcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUBCKcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:32:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:34993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265860AbUBCKcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:32:32 -0500
Date: Tue, 3 Feb 2004 02:33:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.2-rc3-mm1
Message-Id: <20040203023359.59dc0613.akpm@osdl.org>
In-Reply-To: <20040202235817.5c3feaf3.akpm@osdl.org>
References: <20040202235817.5c3feaf3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc3/2.6.2-rc3-mm1/

There were some problems with vm-rss-limit-enforcement.patch.  I've backed
that out and uploaded 2.6.2-rc3-mm1-1.  This is mainly for Nick to patch
against, but if pageout performance problems are noticed, please try -1.

