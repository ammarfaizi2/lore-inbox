Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUFRJ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUFRJ3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUFRJ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:29:19 -0400
Received: from mail.dif.dk ([193.138.115.101]:10135 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265092AbUFRJ25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:28:57 -0400
Date: Fri, 18 Jun 2004 11:27:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Nick Bartos <spam99@2thebatcave.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using kernel headers that are not for the running kernel
In-Reply-To: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
Message-ID: <Pine.LNX.4.56.0406181124350.16649@jjulnx.backbone.dif.dk>
References: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Nick Bartos wrote:

> I have a little distro that I am trying to upgrade to 2.6.x.
>
> The problem is that when I use the headers for 2.6.x, glibc 2.2.5 won't
> compile.  Eventually I want to upgrade glibc/gcc, but not at the moment.
> If I use the headers from 2.4.26 for the system, but just compile the
> 2.6.7 kernel, things do compile fine for everything.
>
[snip]
>
> Comments?
> -

I think this covers the issues you are having pretty well :
http://www.linuxmafia.com/faq/Kernel/usr-src-linux-symlink.html


--
Jesper Juhl <juhl-lkml@dif.dk>

