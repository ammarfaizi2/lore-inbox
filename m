Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280683AbRKGMdV>; Wed, 7 Nov 2001 07:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280697AbRKGMdD>; Wed, 7 Nov 2001 07:33:03 -0500
Received: from catv-213-100-44-203.swipnet.se ([213.100.44.203]:12160 "EHLO
	nex.hemma.se") by vger.kernel.org with ESMTP id <S280691AbRKGMco> convert rfc822-to-8bit;
	Wed, 7 Nov 2001 07:32:44 -0500
Date: Wed, 7 Nov 2001 13:32:38 +0100 (CET)
From: =?ISO-8859-1?Q?Bj=F6rn_Lindberg?= <d95-bli@nada.kth.se>
X-X-Sender: <bjorn@nex.hemma.se>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel crash when running program in gdb
Message-ID: <Pine.LNX.4.33.0111071320460.196-100000@nex.hemma.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My kernel crashes when I try run a program in gdb. The error output is
below. I run kernel 2.4.13-ac5. Is attachments allowed to this list? I
could attach the binary.

The drive is a one year old IBM drive, and everything else is working
perfectly, eg. I have compiled and installed several programs without
trouble.

Please CC me any replies, because I'm not subscribed to the list.

----<begin>----
dma_intr: status=0x51 {DriveReady SeekComplete Error}
dma_intr: error=0x40 {UncorrectableError}, LBAsect=45039979, sector=218486
end_request: I/O error, dev 21:0a (hde), sector 218486
-----<end>-----


Björn Lindberg
Stockholm
Sweden

