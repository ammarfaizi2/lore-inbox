Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSGQEJe>; Wed, 17 Jul 2002 00:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318206AbSGQEJd>; Wed, 17 Jul 2002 00:09:33 -0400
Received: from tyler.snap.net.nz ([202.37.101.20]:11739 "EHLO
	tyler.snap.net.nz") by vger.kernel.org with ESMTP
	id <S318205AbSGQEJd>; Wed, 17 Jul 2002 00:09:33 -0400
Message-ID: <000501c22d48$e6940230$0200a8c0@john>
From: "John Schaper" <schaper@inet.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: A kernel bug of sorts...
Date: Wed, 17 Jul 2002 16:17:43 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick note... it appears that "i2c-old.h" has been omitted from the
2.5.25 kernel source (tar.bz2).

Keep on the good work...

cheers
John Schaper

PS I am looking to implement a "quick" way to use the S510 USB video grabber
board released by many companies (although no longer manufactured).  This
appears to be a SAA7111/W9966CF combo with the lucent USS720 chip to magic
into a USB style adapter.  Pretty standard I think.  Although if anyone else
has already solved this trivial issue, it would save me some time.


