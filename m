Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTIQIuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 04:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbTIQIuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 04:50:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:15829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262712AbTIQIub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 04:50:31 -0400
Date: Wed, 17 Sep 2003 01:51:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Daniel Engelschalt" <daniel.engelschalt@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5: Unable to handle kernel paging request
Message-Id: <20030917015113.0a47c88e.akpm@osdl.org>
In-Reply-To: <31985.1063787066@www40.gmx.net>
References: <31985.1063787066@www40.gmx.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Daniel Engelschalt" <daniel.engelschalt@gmx.net> wrote:
>
> using 2.6.0-test5 vanilla i get the following:
> 
>  Sep 17 09:04:05 A405a kernel: Unable to handle kernel paging request at virtual address 080000b0

bitflip while freeing a negative dentry.

> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 807.511

Your computer is old, and tired.

Try running memtest86 for 12 hours.
