Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSL0Is0>; Fri, 27 Dec 2002 03:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSL0Is0>; Fri, 27 Dec 2002 03:48:26 -0500
Received: from smtp006.mail.tpe.yahoo.com ([202.1.238.137]:1331 "HELO
	smtp006.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S264844AbSL0IsZ>; Fri, 27 Dec 2002 03:48:25 -0500
Message-ID: <004e01c2ad85$d9eeb2b0$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>
Cc: <linux-kernel@vger.kernel.org>
References: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw> <20021226174653.GA8229@kroah.com> <003d01c2ad4a$54eb09f0$3716a8c0@taipei.via.com.tw> <3E0BC155.5B291F57@eyal.emu.id.au>
Subject: Re: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
Date: Fri, 27 Dec 2002 16:55:19 +0800
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

> Check that you actually have /dev/scd0. I think it should be:
> # mknod /dev/scd0 b 11 0
> 
 I've checked the node as follows.
#ls -l /dec/scd0
brw-r----- 1 root  disk 11,  0 Sep 9 13:24 /dev/scd0

Any idea? Thanks in advance.
BR,
 Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
