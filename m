Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130128AbQKLFxC>; Sun, 12 Nov 2000 00:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbQKLFwx>; Sun, 12 Nov 2000 00:52:53 -0500
Received: from mail.inconnect.com ([209.140.64.7]:50920 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S130128AbQKLFwj>; Sun, 12 Nov 2000 00:52:39 -0500
Date: Sat, 11 Nov 2000 22:52:38 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: /net/ip_vs.h in stock kernels
In-Reply-To: <3A0C91C7.D5530CFF@timpanogas.org>
Message-ID: <Pine.SOL.4.21.0011112251070.15229-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey said once upon a time (Fri, 10 Nov 2000):

> 
> I noticed that the ip_vs.h include is not in the main kernel tree or ip
> virtual switch support while I was attempting to buid the pirahnna web
> server.  Is this module a patch located somewhere else on
> ftp.kernel.org.

Jeff,
	Red Hat started included the IPVS patches from
http://www.linuxvirtualserver.org/ starting with RH6.1 (I believe).  You
can find the patch they use in the kernel src.rpm, or go get the patch
from the URL listed above.

Dax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
