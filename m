Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293697AbSCAT6h>; Fri, 1 Mar 2002 14:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293695AbSCAT5v>; Fri, 1 Mar 2002 14:57:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293681AbSCAT5l>; Fri, 1 Mar 2002 14:57:41 -0500
Date: Fri, 1 Mar 2002 14:57:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jerry Zhu <flylikewind@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The partition information lost
In-Reply-To: <20020301193813.59830.qmail@web11402.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020301145532.233A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Jerry Zhu wrote:

> Hi,
> 
> The partition information of a SCSI hard drive
> is lost, is there anyone who can give me some
> advices to recover the hard drive ?
> 
> Thanks in advance.

If you have written down the information, you can use  linux `fdisk`
because it doesn't write anything but the partition information so,
if you have the correct partition information, you can recover the
file-systems.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

