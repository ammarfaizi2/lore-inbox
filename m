Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSHLSWv>; Mon, 12 Aug 2002 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSHLSWv>; Mon, 12 Aug 2002 14:22:51 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.27]:56664 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S318781AbSHLSWu>; Mon, 12 Aug 2002 14:22:50 -0400
Message-ID: <008401c2422d$c34de9e0$0200010a@jennifer>
Reply-To: "Dhr N. Van Alphen" <mastex@servicez.org>
From: "Dhr N. Van Alphen" <mastex@servicez.org>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.5.31 make menuconfig
Date: Mon, 12 Aug 2002 20:26:23 +0200
Organization: Genetics BV
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After unpacking kernel 2.5.31 source and running 'make menuconfig"
its fails with this error:

In file included from /usr/include/netinet/in.h:212,
                 from fixdep.c:107:
/usr/include/bits/socket.h:298: asm/socket.h: No such file or directory
make[1]: *** [fixdep] Error 1

i know i prolly should make some simlinks but im too lazy, can't anyone
figure a way not too :)

Greets Niek van alphen


