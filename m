Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUBBQEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUBBQEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:04:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52098 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265678AbUBBQEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:04:38 -0500
Date: Mon, 2 Feb 2004 11:06:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Flashing keyboard LEDS upon boot.
In-Reply-To: <Pine.LNX.4.53.0402021043450.24519@chaos>
Message-ID: <Pine.LNX.4.53.0402021105560.24632@chaos>
References: <Pine.LNX.4.53.0402021043450.24519@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004, Richard B. Johnson wrote:

>
> Sometimes, when booting Linux-2.3.24 from bzImage, machines
                                  ^
Typo                      Linux-2.4.24

> display "Uncompressing Linux ..., Ok. Booting the kernel."
> Then the machine just sits there with the keyboard LEDS
> (Num-Lock, Caps-lock, and Scroll-lock) flashing at about
> a 1-second interval. It will do this "forever".
>
> Can anybody tell me what it has found "wrong" that prevents
> it from continuing the boot? A whole bunch of new Dell Computers
> display this problem. The second boot will always work, but
> the first cold-start boot will often result in this problem.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


