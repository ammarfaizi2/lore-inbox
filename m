Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVIKThH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVIKThH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIKThH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:37:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750822AbVIKThF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:37:05 -0400
Date: Sun, 11 Sep 2005 12:36:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: 2.6.13-mm2
Message-Id: <20050911123627.2551a057.akpm@osdl.org>
In-Reply-To: <200509111903.38938.rjw@sisk.pl>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<200509111903.38938.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
>  > 
>  > (kernel.org propagation is slow.  There's a temp copy at
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> 
>  Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
>  into -mm?  My box does not resume from disk without it.

No probs.

Daniel, do you remember why we decided to drop it?  What should we do about
this?  Thanks.

