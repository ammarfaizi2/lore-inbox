Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136146AbRECH31>; Thu, 3 May 2001 03:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136148AbRECH3H>; Thu, 3 May 2001 03:29:07 -0400
Received: from hqvsbh1-x0.ms.com ([205.228.12.101]:35555 "EHLO hqvsbh1.ms.com")
	by vger.kernel.org with ESMTP id <S136146AbRECH3E>;
	Thu, 3 May 2001 03:29:04 -0400
Message-ID: <3AF108BE.E8957686@morganstanley.com>
Date: Thu, 03 May 2001 08:29:02 +0100
From: Richard Polton <Richard.Polton@morganstanley.com>
Reply-To: Richard.Polton@morganstanley.com
Organization: Morgan Stanley
X-Mailer: Mozilla 4.75 [en]C-CCK-MCD MS4.75 V20001029.1  (WinNT; U)
X-Accept-Language: en,ja
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: cannot find directory on cdrom
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a cdrom burnt by a friend with W2000 (I know, friends don't let
friends use W ;-) which has (at least) one directory on it which I
cannot
see when mounting the disk under linux. I am using kernel 2.4.4 and
the mount command is the usual

mount /dev/cdrom /mnt/cdrom -t iso9660

I have Joliet compiled into the kernel too. I can send by private email
the
first 120 blocks or so of the disk if anyone is interested. I looked at
this
with hexlify and can see the mysterious directory (s?) which is called
'sturf'.

Thanks,

Richard

P.S. Incidentally, there is an undefined symbol in video/media/buz.c --
KMALLOC_MAXSIZE, which I found by accidentally trying to build this
module even though I do not have the requisite hardware 8-)

