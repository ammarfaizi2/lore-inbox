Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSFNLuz>; Fri, 14 Jun 2002 07:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSFNLuy>; Fri, 14 Jun 2002 07:50:54 -0400
Received: from 205-158-62-93.outblaze.com ([205.158.62.93]:46469 "HELO
	ws3-3.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317576AbSFNLux>; Fri, 14 Jun 2002 07:50:53 -0400
Message-ID: <20020614115049.16384.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Domcan Sami" <domca_psg@email.com>
To: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
        redhat-list@redhat.com
Date: Fri, 14 Jun 2002 06:50:49 -0500
Subject: Kernel - arch support(mips)
X-Originating-Ip: 202.140.142.131
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to compile a program using a MIPS-LINUX cross compiler(gcc). I've set up a connection between my i386 Linux machine and a MIPS(RM7000) processor. This is again connected to a WinNT Terminal where there should be an output from the MIPS processor.

I have 2 kernels in my Linux machine under the directories:
1) /usr/src/linux - kernel version 2.2.14
2) /root/kernels/linux - kernel version 2.4.14

I am using a boot image generated from the older kernel for booting. The problem is the older kernel doesn't support MIPS architecture. What should I do to upgrade my kernel so that it supports MIPS architecture & that I'll be able to cross-compile my programs properly.

Domcan
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

