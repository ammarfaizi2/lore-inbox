Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbRESItH>; Sat, 19 May 2001 04:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbRESIs5>; Sat, 19 May 2001 04:48:57 -0400
Received: from [209.102.21.2] ([209.102.21.2]:55812 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S261709AbRESIsq>;
	Sat, 19 May 2001 04:48:46 -0400
Message-ID: <3B06338E.81D72C9A@goingware.com>
Date: Sat, 19 May 2001 04:49:23 -0400
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "Why We Should All Test the New Linux Kernel" updated
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated my article "Why We Should All Test the New Linux Kernel"
that was originally posted on Advogato just before 2.4.0 was release and
posted it in a new location:

http://linuxquality.sunsite.dk/articles/whytestkernel/

I welcome your comments, please write to crawford@goingware.com

A number of people wrote in with comments and corrections after I wrote
the original article, but Advogato doesn't provide for editing an
article once it's posted - one can only make replies.  In this revision
I could fix things throughout the text and can keep it updated as I
think of ways to improve it in the future.

It discusses why its important to test the kernel, where to get test
kernels and how to get started with them, gives the minimum version
numbers of the programs listed in 
Documentation/Changes from 2.4.4, with links to where to download
updates, and ends with an in-depth discussion of why something like a
kernel needs particularly thorough testing - the reason being that
disrupting the virtual machine in a kernel has non-local effects on a
system; screwing up a user-mode program will usually just mess up that
one program, but screwing up a kernel can make all kinds of weird things happen.

Regards,

Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com
crawford@goingware.com

    Tilting at Windmills for a Better Tomorrow.
