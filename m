Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbSKPXst>; Sat, 16 Nov 2002 18:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbSKPXst>; Sat, 16 Nov 2002 18:48:49 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:11848 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267408AbSKPXss>; Sat, 16 Nov 2002 18:48:48 -0500
Message-ID: <3DD6DADC.F5BE96E6@cinet.co.jp>
Date: Sun, 17 Nov 2002 08:55:08 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac5-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: PC-9800 on 2.5.47-ac5
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alan. 2.5.47-ac5 works fine for my PC-9800 box
 with additional patch. I put additional patch next URL.
http://downloads.sourceforge.jp/linux98/1561/linux98-2.5.47-ac5.patch.tar.bz2

But I met some not PC-9800 specific problems.
 - Doesn't boot when compile for i386 or i486.
 - Oops when remove a Card from CardBus socket.

Regards,
Osamu
