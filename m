Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266920AbRGHQs6>; Sun, 8 Jul 2001 12:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRGHQst>; Sun, 8 Jul 2001 12:48:49 -0400
Received: from [194.213.32.142] ([194.213.32.142]:6660 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266920AbRGHQsq>;
	Sun, 8 Jul 2001 12:48:46 -0400
Date: Sat, 30 Jun 2001 14:10:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about linux mips ext2fs
Message-ID: <20010630141022.B142@toy.ucw.cz>
In-Reply-To: <20010625155706.66345.qmail@web13907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010625155706.66345.qmail@web13907.mail.yahoo.com>; from wqb123@yahoo.com on Mon, Jun 25, 2001 at 08:57:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I want port linux to our mipsel system. The kernel
> can work and system stop at mount root file system.
> I download root file system for mipsel from MIPS
> company. Because our system have no ethernet
> interface,
> I have to copy root file system directly to our hard
> disk. I put hard disk under intel linux, and using 
> fdisk and make ex2fs on it. Then I copy root file 
> system to hard disk. After finished, I place this hard
> disk under our mipsel environment. I do not know if 
> it can work under this environment, the kernel can
> mount root file system? If someone knows, please help
> me.

Yes, it can work.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

