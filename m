Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbREZW7F>; Sat, 26 May 2001 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbREZW64>; Sat, 26 May 2001 18:58:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262137AbREZW6k>;
	Sat, 26 May 2001 18:58:40 -0400
Message-ID: <006e01c0e616$e849e600$44a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mike Galbraith" <mikeg@wen-online.de>
Cc: "Alan Cox" <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <Pine.LNX.4.33.0105251401220.476-100000@mikeg.weiden.de>
Subject: Re: Linux 2.4.4-ac17
Date: Sat, 26 May 2001 12:06:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The OS resides on disk, yes.  I suppose I could plunk a minimal
> system into ramfs, pivot_root and umount disk, but I don't see
> any way that could matter for a memory leak.
>

It is very difficult to see memory leak , with hard disks .

As i told you , in my case i am using no harddisks , only thing i have is
RAM , so i am using only Ramdisk and ramfs, so in my case my Ram will full
within few minutes and My machine hangs .

Thanks ,

Jaswinder.
--
These are my opinions not 3Di.


