Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbSLOKdm>; Sun, 15 Dec 2002 05:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSLOKdm>; Sun, 15 Dec 2002 05:33:42 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:8250 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266320AbSLOKdm>; Sun, 15 Dec 2002 05:33:42 -0500
Message-ID: <3DFC5BD0.C815E8C7@cinet.co.jp>
Date: Sun, 15 Dec 2002 19:39:12 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (2/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (2/21)
This is updates for include/asm-i386/gdc.h.
Killed warning from gcc-3.2.

diffstat:
 include/asm-i386/gdc.h |  144 ++++++++++++++++++++++++++-----------------------
 1 files changed, 79 insertions(+), 65 deletions(-)


Regards,
Osamu Tomita
