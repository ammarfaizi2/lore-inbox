Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTE1VzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTE1VzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:55:19 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8817 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261180AbTE1VzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:55:18 -0400
Date: Wed, 28 May 2003 15:06:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-Id: <20030528150610.3df70031.akpm@digeo.com>
In-Reply-To: <20030528215551.GB255@elf.ucw.cz>
References: <20030521152255.4aa32fba.akpm@digeo.com>
	<20030521152334.4b04c5c9.akpm@digeo.com>
	<20030526093717.GC642@zaurus.ucw.cz>
	<20030528144839.47efdc4f.akpm@digeo.com>
	<20030528215551.GB255@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 22:08:34.0809 (UTC) FILETIME=[AE9F0E90:01C32565]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Here is common part. That should enable architecture maintainers to
> pick it up when *they* need. So it is late but it should not be
> intrusive. Here it is.

 25-akpm/fs/compat_ioctl.c | 2491 ++++++++++++++++++++++++++++++++++++++++++++++

I am utterly clueless when it comes to this 32-bit compat stuff.  How does
the architecture actually use this?  #include it?

Have any architectures been converted?  Any example implementations
available?

