Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUCSQcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUCSQcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:32:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6287 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263111AbUCSQcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:32:09 -0500
Date: Fri, 19 Mar 2004 11:34:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CDFS
In-Reply-To: <20040319081039.74a827fe.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0403191127040.3230@chaos>
References: <Pine.LNX.4.53.0403191100030.3154@chaos> <20040319081039.74a827fe.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Randy.Dunlap wrote:

> On Fri, 19 Mar 2004 11:01:44 -0500 (EST) Richard B. Johnson wrote:
>
> |
> | Just got a CD/ROM that 'works' on W$, but not Linux.
> | W$ `properties` call it 'CDFS'. Is there any such Linux
> | support?
>
> You did try to search for it, right?
>

Sure did and what I get was an explaination that, for
Linux, the letters "CDFS" refer to something that "exports
all the tracks and boot images of a CD as normal files".

That's not what I want. I want to mount a CDFS file-system.

Given that, maybe the explaination is bogus, but I
need some CDFS file-system support so I can mount
a Microsoft CDFS CD/ROM. If such support exists, I
would think that I should be able to do:

mount -t cdfs /dev/cdrom /mnt


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


