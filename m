Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbRGVDic>; Sat, 21 Jul 2001 23:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbRGVDiW>; Sat, 21 Jul 2001 23:38:22 -0400
Received: from web14506.mail.yahoo.com ([216.136.224.69]:36622 "HELO
	web14506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267878AbRGVDiL>; Sat, 21 Jul 2001 23:38:11 -0400
Message-ID: <20010722033816.35302.qmail@web14506.mail.yahoo.com>
Date: Sat, 21 Jul 2001 20:38:16 -0700 (PDT)
From: Hunt Kent <kenthunt@yahoo.com>
Subject: Tulip driver in 2.4 for LANfinity (Conexant)
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Does anyone know what is the status of the tulip 
driver for the LANfinity NIC Conexant in presario
laptops for kernel 2.4? The experimental driver
(0.92w) for 2.2 kernels is working okay. Compiling the
2.2 driver in 2.4.7 kernel works fine but it doesn't
insmod in the kernel because of missing symbols.
Perhaps tweaking kern_compat.h (v1.9 2001/07/13) would
make it work.

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
