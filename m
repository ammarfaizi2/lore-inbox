Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278452AbRJVJmL>; Mon, 22 Oct 2001 05:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278453AbRJVJmB>; Mon, 22 Oct 2001 05:42:01 -0400
Received: from web14703.mail.yahoo.com ([216.136.224.120]:13836 "HELO
	web14703.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278457AbRJVJlv>; Mon, 22 Oct 2001 05:41:51 -0400
Message-ID: <20011022094224.99093.qmail@web14703.mail.yahoo.com>
Date: Mon, 22 Oct 2001 02:42:24 -0700 (PDT)
From: Peter Moscatt <pmoscatt@yahoo.com>
Subject: Can't See CDR-W After Compile ??
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled my first kernel (2.4.10) and all has
gone well except I now can't access the CDR-W.

I have included SCSI Support and included what I think
may need to be loaded as well.

I see it as an IDE drive but has no SCSI-Emulation.

I have had a look through DMESG to get an idea what's
happening, and I see the message:

 "request_module[scsi_hostadapter]: Root fs not
mounted"

What have I left out ?

Pete

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
