Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRHWXtl>; Thu, 23 Aug 2001 19:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270783AbRHWXtc>; Thu, 23 Aug 2001 19:49:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270774AbRHWXtT>; Thu, 23 Aug 2001 19:49:19 -0400
Subject: Re: File System Limitations
To: fred@arkansaswebs.com (Fred)
Date: Fri, 24 Aug 2001 00:52:29 +0100 (BST)
Cc: tmh@nothing-on.tv (Tony Hoyle), linux-kernel@vger.kernel.org
In-Reply-To: <01082318405901.12319@bits.linuxball> from "Fred" at Aug 23, 2001 06:40:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a4Gz-0004uz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> glibc-2.2.2-10

Your C library is new enough

> [root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
> File size limit exceeded (core dumped)

But your dd program might not be

Alan
