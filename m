Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSJZFQX>; Sat, 26 Oct 2002 01:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbSJZFQX>; Sat, 26 Oct 2002 01:16:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12083 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261866AbSJZFQW>; Sat, 26 Oct 2002 01:16:22 -0400
To: Mike Galbraith <efault@gmx.de>
Cc: robert w hall <bobh@n-cantrell.demon.co.uk>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: loadlin with 2.5.?? kernels
References: <m1bs5in1zh.fsf@frodo.biederman.org>
	<5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
	<5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
	<m18z0os1iz.fsf@frodo.biederman.org>
	<007501c27b37$144cf240$6400a8c0@mikeg>
	<m1bs5in1zh.fsf@frodo.biederman.org>
	<5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Oct 2002 23:20:41 -0600
In-Reply-To: <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
Message-ID: <m13cqtn5cm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> writes:

> At 11:00 PM 10/25/2002 +0100, robert w hall wrote:
> 
> >Hans Lermen changed the gdt structure in version 1.6b to enable it to
> >boot a win4lin-enabled kernel - he also changed things recently (1.6c)
> >to boot kernels of between 0.5 &1.5Mb compressed.
> 
> (1.5MB?  I remember hitting the 1MB wall even after grabbing 1.6c.  hmm..)
> 
> I went back and double-checked my loadlin version, and it turned out I was
> actually using 1.6a due to a fat finger.  Version 1.6c booted fine (only one
> kernel tested) without Eric's help.  1.6a definitely needs Eric's help to boot.

Darn.  I guess the arguments for my patch may not be quite as good,
but I still think it may be worth while.
 
> (gee, it works.  sure hope I don't hit the new lard limit any time soon;)

I wonder what the change in 1.6b was....

Eric
