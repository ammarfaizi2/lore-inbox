Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267299AbUBNAvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUBNAvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:51:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:9624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267299AbUBNAvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:51:02 -0500
Date: Fri, 13 Feb 2004 16:52:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davej@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscalls.h update #9 (open/close)
Message-Id: <20040213165239.44a8dbb9.akpm@osdl.org>
In-Reply-To: <20040213163559.75f877b1.rddunlap@osdl.org>
References: <20040213163559.75f877b1.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Here's the next installment in moving syscall prototypes
> to linux/syscalls.h and removing the ad hoc instances of them.

Thanks, Randy.  I am astonished at how much there was to do.

