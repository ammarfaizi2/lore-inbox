Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUGAH24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUGAH24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUGAH2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:28:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:59361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264236AbUGAH2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:28:54 -0400
Date: Thu, 1 Jul 2004 00:27:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm5
Message-Id: <20040701002753.68a4739d.akpm@osdl.org>
In-Reply-To: <40E3B9F8.8070105@gts.it>
References: <20040630172656.6949ec60.akpm@osdl.org>
	<40E3B9F8.8070105@gts.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Andrew Morton wrote:
> 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/
>  > 
>  > - bk-acpi.patch is back.  If devices mysteriously fail to function please
>  >   try reverting it with
> 
>  Hangs on boot, after ide0 detection: last 3 lines are
> 
>  hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
>  Using anticipatory io scheduler
>  ide0 at 0x1f0-0x1f7, 0x3f6 on irq14
> 
>  then it hangs

What would the next message have been, if it had not hung up?
