Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUFKTjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUFKTjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 15:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUFKTjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 15:39:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264251AbUFKTjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 15:39:21 -0400
Date: Fri, 11 Jun 2004 15:38:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>, bj0rn@blox.se
Subject: Re: kernel/module compiler version problem
In-Reply-To: <40CA04F0.9000307@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0406111537160.1436@chaos>
References: <40CA04F0.9000307@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004, Chris Friesen wrote:

> I'm running 2.4.22, build with gcc 3.3.1, modutils 2.4.22.
>
> I have an ATM driver that is shipped with a binary blob and a source code shim.
>   It compiles fine.  When I go to load it, I get the following error:
>
> "The module you are trying to load is compiled with a gcc
> version 2 compiler, while the kernel you are running is compiled with
> a gcc version 3 compiler. This is known to not work."
>
> Presumably the binary blob was compiled with gcc 2.x?  Is there any way to
> override this?  "insmod -f" doesn't seem to work.
>
> Thanks,
>
> Chris

Get a new blob from the blob vendor. Of course you may have just
installed a worm....

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


