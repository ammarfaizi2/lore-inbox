Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274843AbRIZFvl>; Wed, 26 Sep 2001 01:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274845AbRIZFvb>; Wed, 26 Sep 2001 01:51:31 -0400
Received: from zok.sgi.com ([204.94.215.101]:37255 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274843AbRIZFvW>;
	Wed, 26 Sep 2001 01:51:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Moritz Moeller-Herrmann <mmh@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oopses: i386 linux-2.4.10, es1371 sound card, analog joystick 
In-Reply-To: Your message of "Wed, 26 Sep 2001 01:42:44 +0200."
             <20010926014233.A1010@rosalind.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 15:51:39 +1000
Message-ID: <29822.1001483499@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 01:42:44 +0200, 
Moritz Moeller-Herrmann <mmh@gmx.net> wrote:
>ksymoops 2.4.1 on i686 2.4.10.  Options used
>Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d0a39460, /lib/modules/2.4.10/kernel/drivers/usb/usbcore.o says d0a39320.  Ignoring /lib/modules/2.4.10/kernel/drivers/usb/usbcore.o entry
>18 warnings issued.  Results may not be reliable.
>****************
>Why do I get these warnings?

ksymoops bug, fixed in ksymoops 2.4.2.  2.4.3 is out now.

