Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSJZEwC>; Sat, 26 Oct 2002 00:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSJZEwC>; Sat, 26 Oct 2002 00:52:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9523 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261854AbSJZEwB>; Sat, 26 Oct 2002 00:52:01 -0400
To: robert w hall <bobh@n-cantrell.demon.co.uk>
Cc: Mike Galbraith <EFAULT@gmx.de>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
	<5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
	<m18z0os1iz.fsf@frodo.biederman.org>
	<007501c27b37$144cf240$6400a8c0@mikeg>
	<m1bs5in1zh.fsf@frodo.biederman.org>
	<ApOnXDAL8bu9EwOR@n-cantrell.demon.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Oct 2002 22:56:20 -0600
In-Reply-To: <ApOnXDAL8bu9EwOR@n-cantrell.demon.co.uk>
Message-ID: <m17kg5n6h7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

robert w hall <bobh@n-cantrell.demon.co.uk> writes:

> which version of loadlin does this patch?

It doesn't it patches the kernel so that it follows the documented
kernel boot protocol.

> Hans Lermen changed the gdt structure in version 1.6b to enable it to
> boot a win4lin-enabled kernel - he also changed things recently (1.6c)
> to boot kernels of between 0.5 &1.5Mb compressed.

With the small kernel restructuring a patch is unlikely to be needed
to boot a win4lin-enabled kernel either.
 
> (IF I sat down for half an hour I could comment better.. but you
> probably know the answer straight-off anyway :-))

Eric
