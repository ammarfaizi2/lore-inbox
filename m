Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbREFJNe>; Sun, 6 May 2001 05:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbREFJNY>; Sun, 6 May 2001 05:13:24 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:41268 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S135266AbREFJNQ>; Sun, 6 May 2001 05:13:16 -0400
Message-ID: <001201c0d60c$a5a3c920$3303a8c0@pnetz>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
Date: Sun, 6 May 2001 11:12:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maybe, but the IWILL board is the only one we've heard about problems with.

I have also stability problems with an ASUS A7V133. I already have the
1004-d2 bios which should fix the VIA IDE problems. But my hard drives are
connected to the promise controller of the board. Only 2 CD-drives are on
teh VIA-Chip.

I am quite sure that my problem was introduced with 2.4.3-ac7, because, the
board is rock solid up to kernel 2.4.3-ac6 or with the Madrake 8 kernel.
But If I try to put some load on 2.4.3-ac7 or above I get lock ups. Even the
magic sysrq does not work. No matter if compiled for athlon Pentium II or
586.
No matter if I use the mandrake 8 gcc 2.96 or a self compiled gcc 2.95.3.
The problem also occurs on kernel 2.4.4.


Bytheway there is a thread called "ABit KT7A-RAIN random lock ups "
It might be related to one of the Athlon/VIA problems.



greetings
Christian



