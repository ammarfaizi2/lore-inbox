Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSLURtf>; Sat, 21 Dec 2002 12:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSLURtf>; Sat, 21 Dec 2002 12:49:35 -0500
Received: from cm218-252-15-175.hkcable.com.hk ([218.252.15.175]:9601 "EHLO
	cm218-252-15-175.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S262354AbSLURte>; Sat, 21 Dec 2002 12:49:34 -0500
From: "Sampson Fung" <sampson.fung@attglobal.net>
To: <linux-kernel@vger.kernel.org>
Subject: How to help new comers trying the v2.5x series kernels.
Date: Sun, 22 Dec 2002 01:57:33 +0800
Message-ID: <000701c2a91a$707254a0$0100a8c0@noelpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From v2.5.49 up, I can only test the compiled kernel, if it compiles at
all, with modules disabled completely.
Of course, I have to say that I do not try much before v2.5.49.

I think new comers, myselft included, can make use of standard templates
of kernel .config file.

First of all, "standard templates" are tested that they will be compiled
without problem.
They should be able to boot.
They should have a working "framework" of "modules", for example, lsmod
works without any problem.  (And any other "required" modutils as well)
They shuold supports further kernel compile. (With small incremental
changes to the base "standard template").

Then I can try to compile my lan card as modules.
Then try to compile my SCSI card, etc, etc.

Does similar "standard templates" exist already?  

Where can I search for known bugs centrally, so that I can help myself
as much as possible?

Regards,
Sampson Fung
sampson@attglobal.net




