Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269674AbRHIKbk>; Thu, 9 Aug 2001 06:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269751AbRHIKbb>; Thu, 9 Aug 2001 06:31:31 -0400
Received: from druid.if.uj.edu.pl ([149.156.64.221]:57614 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S269674AbRHIKbS>; Thu, 9 Aug 2001 06:31:18 -0400
Date: Thu, 9 Aug 2001 12:31:31 +0200 (CEST)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Carl-Johan Kjellander <carljohan@kjellander.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 386 boot problems with 2.4.7 and 2.4.7-ac9
In-Reply-To: <3B706C11.7010100@kjellander.com>
Message-ID: <Pine.LNX.4.33.0108091228380.6063-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The system is a 386DX with an Award 3.15c BIOS. The distribution
> is smalllinux i think, but I've modified it a lot.

99% sure that your problem is binaries for 486 and up, had this problem
installing RedHat 7.1 on a 486 with no CDROM drive - did the installation
on a Pentium 3, then it would not boot, compiled a new kernel for 486,
installed that on the P 3, now it booted on the 486 but would not run
init.  The binaries were for 686 and refused to run...

MaZe.

PS. There should be a choich when installing RedHat in advanced mode what
processor you want to install for - often enough the computer you are
installing on is not quite the same as the one it will be running on.

