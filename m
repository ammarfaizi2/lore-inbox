Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270398AbTGRUyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTGRUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:54:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:38280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271851AbTGRUxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:53:31 -0400
Date: Fri, 18 Jul 2003 14:00:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
Message-Id: <20030718140019.4f6667bd.akpm@osdl.org>
In-Reply-To: <200307181228.40142.gallir@uib.es>
References: <200307181228.40142.gallir@uib.es>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> wrote:
>
>  Unable to handle kernel paging request at virtual address e9000018
> EIP is at find_inode_fast+0x20/0x70
> Call Trace:
>  [<c0168e42>] iget_locked+0x52/0xc0
>  [<c018a54b>] ext3_lookup+0x6b/0xd0
>  [<c015cd92>] real_lookup+0xd2/0x100

What is "famd"?  File access monitor daemon?  From where did you obtain it?

