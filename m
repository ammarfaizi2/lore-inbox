Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRAPQ2U>; Tue, 16 Jan 2001 11:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbRAPQ2L>; Tue, 16 Jan 2001 11:28:11 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:43500 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129831AbRAPQ14>;
	Tue, 16 Jan 2001 11:27:56 -0500
Message-Id: <m14IYxY-000OYHC@amadeus.home.nl>
Date: Tue, 16 Jan 2001 17:27:48 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: Venkateshr@ami.com (Venkatesh Ramamurthy)
Subject: Re: Linux not adhering to BIOS Drive boot order?
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1> you wrote:

> we need some kind of signature being written in the drive, which the kernel
> will use for determining the boot drive and later re-order drives, if
> required.

Like the ext2 labels? (man e2label)

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
