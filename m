Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269366AbUIIIIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269366AbUIIIIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269367AbUIIIIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:08:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:52142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269366AbUIIIIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:08:06 -0400
Date: Thu, 9 Sep 2004 01:06:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040909010610.28ca50e1.akpm@osdl.org>
In-Reply-To: <413FA9AE.90304@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> This problem also existed in bk12 but not in the base 2.6.9-rc1.  (I 
>  don't know about other bk versions as I have only tried these two.) It 
>  is triggered by gdmgreeter and gdm-binary.  System being used is Fedora 
>  Core 2 on an UP i386 machine.  The system survives the Oops and is still 
>  usable.

It doesn't happen here (as usual).

Does it happen every time?

Please send me your .config.

Please try earlier snapshots, see if you can ascertain which one introduced
the bug.

Thanks.
