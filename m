Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRCZSrd>; Mon, 26 Mar 2001 13:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRCZSrX>; Mon, 26 Mar 2001 13:47:23 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:46879 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132548AbRCZSrO>; Mon, 26 Mar 2001 13:47:14 -0500
Message-Id: <5.0.2.1.2.20010326204754.02751100@pop.wanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 26 Mar 2001 20:57:22 +0200
To: Tobias Ringstrom <tori@tellus.mine.nu>
From: Theodoor Scholte <tscholte@wanadoo.nl>
Subject: Re: Compiling problem kernel 2.4.2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103261849370.30156-100000@svea.tellus>
In-Reply-To: <5.0.2.1.2.20010326184036.0251b040@pop.wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>And you always get exactly this message?  What happens if you run
>     cat /usr/src/linux/include/linux/compile.h

This is the output of cat /usr/src/linux/include/linux/compile.h :
#define UTS_VERSION "#1 SMP Sun Mar 25 21:51:51 CEST 2001"
#define LINUX_COMPILE_TIME "21:51:51"
#define LINUX_COMPILE_BY "root"
#define LINUX_COMPILE_HOST "server"
#define LINUX_COMPILE_DOMAIN "scholte.nl"
#define LINUX_COMPILER "gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 
release)"


>     dd if=/dev/zero of=/usr/src/linux/include/linux/compile.h count=10

This is the output of dd if=/dev/zero 
of=/usr/src/linux/include/linux/compile.h count=10 :
10+0 records in
10+0 records out

>Have you checked /var/log/messages (or dmesg) for relevant messages?

There are no relevant messsages in that file.

