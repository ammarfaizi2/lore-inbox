Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUHGFhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUHGFhw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 01:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUHGFhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 01:37:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:62930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266244AbUHGFhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 01:37:50 -0400
Date: Fri, 6 Aug 2004 22:36:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: jraidman-linux@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: elevator abstraction, anticipatory I/O backported to 2.4?
Message-Id: <20040806223616.36bab872.akpm@osdl.org>
In-Reply-To: <20040807000316.85612.qmail@web81706.mail.yahoo.com>
References: <20040807000316.85612.qmail@web81706.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Radel <jraidman-linux@yahoo.com> wrote:
>
> Are there any existing patches for a backport of the
> 2.6 elevator abstraction (or a specific patch for
> anticipatory I/O) to 2.4 kernels?

Not that I know of.

> I've heard rumors that Digeo backported a 2.6 I/O
> scheduler.

No, Digeo use a modified+fixed version of the infamous read_latency2 patch,
against 2.4.20.

> However, when I tried to download their
> open source modifications from
> http://www.digeo.com/prodserv/opensource.jsp, I wasn't
> able to extract their work. (The zip file unzips to a
> tar.bz2, which seems to be corrupt.)

I'll poke someone.

> Who knows, maybe
> an I/O scheduler backport isn't in that archive
> anyway.

Nope, sorry.

