Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262367AbTCICV0>; Sat, 8 Mar 2003 21:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbTCICV0>; Sat, 8 Mar 2003 21:21:26 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:9856 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262367AbTCICVZ>; Sat, 8 Mar 2003 21:21:25 -0500
Message-ID: <3E6AA76A.DB8A46BB@cinet.co.jp>
Date: Sun, 09 Mar 2003 11:31:06 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.64-ac3-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "'Christoph Hellwig '" <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (16/21) SCSI
References: <Pine.GSO.4.21.0303061141180.28248-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> By any chance, you don't have fixes for the wd33c93 abort and reset handling
> (.eh_{abort,bus_reset}_handler)?
I'm testing PC98 patch for 2.5.64(-ac3).
I try to implement error handler in pc980155 driver that uses wd33c93.c.
I'll post them soon.

Thanks,
Osamu Tomita
