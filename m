Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266936AbUBFWUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266954AbUBFWUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:20:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266936AbUBFWUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:20:05 -0500
Date: Fri, 6 Feb 2004 17:20:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Charles Cazabon <linux@discworld.dyndns.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FATAL: Kernel too old
In-Reply-To: <20040206152943.B26348@discworld.dyndns.org>
Message-ID: <Pine.LNX.4.53.0402061718030.917@chaos>
References: <Pine.LNX.4.53.0402061550440.681@chaos> <20040206152943.B26348@discworld.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Charles Cazabon wrote:

> Richard B. Johnson <root@chaos.analogic.com> wrote:
> >
> > Script started on Fri Feb  6 15:44:32 2004
> > # rlogin -l johnson quark
> > ATAL: kernel too old
> > # rlogin -l johnson quark
> > ATAL: kernel too old
>
> I saw something similar at a customer's site, when someone rooted the box and
> replaced the default login shell with a rootkitted/backdoored one in a newer
> executable format not supported by the old kernel.
>
> > I crashed it and it rebooted fine, little fsck activity, with
> > nothing in any logs that shows there was any problem whatsoever.
>
> Did the problem go away with a reboot?

Sure. And if you can 'root' that machine, you are really
good! It isn't even visible to most of the company internally!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


