Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267329AbUG1XXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267329AbUG1XXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUG1XU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:20:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:30136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267331AbUG1XRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:17:41 -0400
Date: Wed, 28 Jul 2004 16:20:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.6.8-rc2-mm1
Message-Id: <20040728162026.55b6266b.akpm@osdl.org>
In-Reply-To: <20040728184921.A17143@mail.kroptech.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
	<20040728184921.A17143@mail.kroptech.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin <akropel1@rochester.rr.com> wrote:
>
> > - If people have patches in here which are important for a 2.6.8 release,
> >   please let me know.
> 
> There's a trivial yet fairly important fix to hiddev.h in bk-input that
> it would be nice to get merged before 2.6.8. Distros have been
> shipping the current in-tree (broken) version with their kernel headers
> packages so a number of userspace apps cannot build. I've broken out the
> patch below.
> 
> There's also a hiddev oops-on-removal fix that ought to be merged fairly
> soon, but I can understand if Vojtech wants that tested a bit longer
> first.

OK, thanks.  Vojtech, can you please sort this matter out?
