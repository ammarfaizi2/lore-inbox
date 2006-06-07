Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWFGWcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWFGWcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWFGWcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:32:05 -0400
Received: from smtp.ono.com ([62.42.230.12]:38747 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932444AbWFGWcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:32:04 -0400
Date: Thu, 8 Jun 2006 00:31:53 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060608003153.36f59e6a@werewolf.auna.net>
In-Reply-To: <20060607104724.c5d3d730.akpm@osdl.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.2.2cvs2 (GTK+ 2.9.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 10:47:24 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> 
> - Many more lockdep updates
> 

I did not realize this the first time:

Root device is (8, 1)
Boot sector 512 bytes.
Setup is 6927 bytes.
System is 1610 kB
Kernel: arch/i386/boot/bzImage is ready  (#2)
  MODPOST
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.16-jam20 (gcc 4.1.1 20060518 (prerelease)) #1 SMP PREEMPT Wed
