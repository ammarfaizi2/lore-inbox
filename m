Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269862AbSISDxc>; Wed, 18 Sep 2002 23:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbSISDxb>; Wed, 18 Sep 2002 23:53:31 -0400
Received: from dp.samba.org ([66.70.73.150]:51359 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269862AbSISDxa>;
	Wed, 18 Sep 2002 23:53:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Wed, 18 Sep 2002 22:19:24 -0400."
             <20020919021924.GA31417@nevyn.them.org> 
Date: Thu, 19 Sep 2002 13:57:57 +1000
Message-Id: <20020919035834.681412C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020919021924.GA31417@nevyn.them.org> you write:
> I still think that the kernel has no business knowing how to parse ELF
> relocation.

Thanks for your feedback.

> It's just as easy to parse it in userspace;

It is?  Thanks for explaining, I thought it was significantly more
difficult.

> and what do you gain from moving the complexity from userspace to
> kernelspace?

Clearly, nothing.  I apologize for wasting your time.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
