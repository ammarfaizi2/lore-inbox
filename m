Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266902AbRGHOVV>; Sun, 8 Jul 2001 10:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbRGHOVL>; Sun, 8 Jul 2001 10:21:11 -0400
Received: from outmail1.pacificnet.net ([207.171.0.246]:37173 "EHLO
	outmail1.pacificnet.net") by vger.kernel.org with ESMTP
	id <S266894AbRGHOVA>; Sun, 8 Jul 2001 10:21:00 -0400
Message-ID: <008001c107b9$3011c660$66b93604@molybdenum>
From: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <22800.994580620@ocs3.ocs-net>
Subject: Re: Unresolved symbols in 2.4.6 
Date: Sun, 8 Jul 2001 09:20:46 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 03:23:17 -0600,
"Keith Owens" <kaos@ocs.com.au> wrote:
>What does 'grep printk /proc/ksyms' report on the 2.4.6 kernel?  Also
>'nm vmlinux | grep printk' against the vmlinux for your 2.4.6 kernel?

My 2.4.6 kernel can't boot because it panics when it goes to mount the root
filesystem. An nm on the kernel returns 'File format not recognized'. It
also returns this error when done on my 2.2.17 kernel, which runs just fine.


