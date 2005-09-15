Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbVIOThF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbVIOThF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbVIOThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:37:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965274AbVIOThC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:37:02 -0400
Date: Thu, 15 Sep 2005 12:36:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: dominik.karall@gmx.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.13-mm3 (general protection fault)
Message-Id: <20050915123620.0389e4aa.akpm@osdl.org>
In-Reply-To: <20050915123438.7ce4b938.akpm@osdl.org>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	<200509152058.13898.dominik.karall@gmx.net>
	<20050915123438.7ce4b938.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Dominik Karall <dominik.karall@gmx.net> wrote:
>  >
>  > On Monday 12 September 2005 11:43, Andrew Morton wrote:
>  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13
>  > >-mm3/
>  > 
>  > hi,
>  > again a general protection fault...
> 
>  scsi or USB I guess.
> 
>  Does the crash happen without loading any proprietary modules?

Also in 2.6.41-rc1.  See

http://bugzilla.kernel.org/show_bug.cgi?id=5265
