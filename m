Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUKKK1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUKKK1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUKKKYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 05:24:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:30426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbUKKKYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 05:24:36 -0500
Date: Thu, 11 Nov 2004 02:24:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm4
Message-Id: <20041111022423.430cf8e3.akpm@osdl.org>
In-Reply-To: <41933C41.2060706@gts.it>
References: <20041109074909.3f287966.akpm@osdl.org>
	<41933C41.2060706@gts.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Just FYI, -mm series on my box always had* the same "trivial" problem: 
>  shutdown won't switch the box off, it just prints "acpi_power_off 
>  called" and then I have to switch it off manually. Not a big deal, but...
> 
>  * at least since 2.6.7 series

That's pretty weird.  There's not much that has been in -mm for that long
without going into Linus's tree.   hmm..

Please let us know asap if this problem starts occurring in Linus's tree. 
That at least will help identify the offending patch.
