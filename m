Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281480AbRKHHpr>; Thu, 8 Nov 2001 02:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281482AbRKHHpi>; Thu, 8 Nov 2001 02:45:38 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:7088 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281480AbRKHHpZ>; Thu, 8 Nov 2001 02:45:25 -0500
Date: Thu, 8 Nov 2001 08:45:12 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: David Rees <dbr@greenhydrant.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk
 I/O - 2.4.13
In-Reply-To: <20011107221148.A7828@greenhydrant.com>
Message-ID: <Pine.LNX.4.40.0111080841130.12597-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.25)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, David Rees wrote:

> >
> > Keywords:
> >
> > vm, ReiserFS, heavy disk I/O,
>
> Let me guess, IDE disks?  Anyway, this is a FAQ.  Go www.namesys.com, click
> on the FAQ, and look at #15.

To bad I did not see the Reiserfs-Keyword before asking...
In my case this happened on scsi-disks on a adaptec 2940.
I read the faq-entry, but I do not understand why this should only apply
to IDE. Maybe my old-scsi disks suffer the same problem ?

Oktay

