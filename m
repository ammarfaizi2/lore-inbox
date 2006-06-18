Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWFRMAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWFRMAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWFRMAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:00:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:402 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932188AbWFRMAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:00:52 -0400
Subject: Re: smp problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ojciec Rydzyk <69rydzyk69@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <32124b660606180356k3ebf7791h40a979b40253210d@mail.gmail.com>
References: <32124b660606180356k3ebf7791h40a979b40253210d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Jun 2006 13:17:32 +0100
Message-Id: <1150633052.11780.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-06-18 am 12:56 +0200, ysgrifennodd Ojciec Rydzyk:
> Hello!
> There is a bug (I suppose) in file linux/boot/i386/kernel/mpparse.c. I
> have laptop Amilo L 7300 and during the kernel boot, I get:
> SMP mptable: bad table version
> BIOS bug, MP table errors detectd!...


What kernel version are you using. This should only occur on 2.4.x
unless the table is checksummed correctly

