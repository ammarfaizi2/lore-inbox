Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314266AbSEFIBA>; Mon, 6 May 2002 04:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEFIA7>; Mon, 6 May 2002 04:00:59 -0400
Received: from CPE-203-51-29-62.nsw.bigpond.net.au ([203.51.29.62]:7809 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314266AbSEFIA7>; Mon, 6 May 2002 04:00:59 -0400
Date: Mon, 6 May 2002 18:04:30 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH 2.5.12] x86 boot enhancements
Message-Id: <20020506180430.16bdee45.rusty@rustcorp.com.au>
In-Reply-To: <m16626zl0h.fsf@frodo.biederman.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 May 2002 08:23:26 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> My patches to build improve the x86 boot process are now
> available at:
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/index.html 
> http://www.xmission.com/~ebiederm/files/boot/index.html
> There is one summary patch and the rest are incremental patches,
> not significant changes have been made.

Hi Eric,

	I've been working on the hotplug CPU stuff: Linus asked that
it alter the boot process to "hotplug in" CPUs on the way up.  I have
some (usually-working) patches for x86, but they conflict with your
work.  Just a heads up...

Cheers!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
