Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbSLLJKu>; Thu, 12 Dec 2002 04:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSLLJKu>; Thu, 12 Dec 2002 04:10:50 -0500
Received: from smtp006.mail.tpe.yahoo.com ([202.1.238.137]:51767 "HELO
	smtp006.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S267453AbSLLJKt>; Thu, 12 Dec 2002 04:10:49 -0500
Message-ID: <002e01c2a1bf$4bfde0b0$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212111151410.1397-100000@twin.uoregon.edu>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Date: Thu, 12 Dec 2002 17:17:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all response. :)
I think I know more why it downgrades.
But one more curious question.
In the file, arch/i386/Makefile, under kernel 2.5.51.
I found the C3 alignments , $(call check_gcc, -march=c3,-march=i486).
Does the C3 CPU type be included in gcc compile option??
I've downloaded the latest gcc 3.2.1 version.
But I don't find the c3 options in the file gcc/config/i396/i386.c, i386.h
or etc.
BR,
  Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
