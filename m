Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUCSVob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUCSVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:44:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262130AbUCSVo3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:44:29 -0500
Date: Fri, 19 Mar 2004 16:44:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stefan Smietanowski <stesmi@stesmi.com>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CDFS
In-Reply-To: <405B681F.3050702@stesmi.com>
Message-ID: <Pine.LNX.4.53.0403191642590.6876@chaos>
References: <Pine.LNX.4.44.0403191640460.3892-100000@einstein.homenet>
 <Pine.LNX.4.53.0403191200120.3752@chaos> <405B681F.3050702@stesmi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Stefan Smietanowski wrote:

> Hi.
>
> > Script started on Fri Mar 19 12:01:38 2004
> > # umount /mnt
> > # umount /mnt
> > umount: /mnt: not mounted
> > # umount -t iso9660 /dev/cdrom /mnt
> ^^^^^^^^
>
> use "mount" instead of "umount" to mount something.
>

I did. Note that `mount` replies below. I don't know why there
is a 'u' in the echo...

    vvv------
> > mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
> >        or too many mounted file systems
> > # exit
> > Script done on Fri Mar 19 12:04:49 2004
>
> // Stefan
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


