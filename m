Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263669AbRFASdQ>; Fri, 1 Jun 2001 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRFASc4>; Fri, 1 Jun 2001 14:32:56 -0400
Received: from web14305.mail.yahoo.com ([216.136.173.81]:36114 "HELO
	web14305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263669AbRFASc3>; Fri, 1 Jun 2001 14:32:29 -0400
Message-ID: <20010601183228.72541.qmail@web14305.mail.yahoo.com>
Date: Fri, 1 Jun 2001 11:32:28 -0700 (PDT)
From: Lee Chin <leechinus@yahoo.com>
Subject: Linux LPP patch on CD ROM not working
To: linux-kernel@vger.kernel.org
Cc: linux-newbie@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am using 2.4.2 kernel and I have applied the LPP
0.40 patch to the kernel to display a nice logo and
progress bar.

I can get this to work when I boot from my harddisk
and floppy with syslinux...
however when I make a CD ISO image from this kernel, I
get no logo or progress bar, instead I get the plain
text boot.

In the syslinux.cfg I am including append vga=0x303 in
all cases.

Thanks
Lee

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
