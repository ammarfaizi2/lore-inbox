Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284555AbRLESS4>; Wed, 5 Dec 2001 13:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284550AbRLESSq>; Wed, 5 Dec 2001 13:18:46 -0500
Received: from alageremail2.agere.com ([192.19.192.110]:30157 "EHLO
	alageremail2.agere.com") by vger.kernel.org with ESMTP
	id <S284549AbRLESSa>; Wed, 5 Dec 2001 13:18:30 -0500
From: "Michael Smith" <smithmg@agere.com>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved symbol memset
Date: Wed, 5 Dec 2001 13:18:37 -0500
Organization: Agere Systems
Message-ID: <009001c17db9$42aa18b0$4d129c87@agere.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
     I am new the Linux world and have a problem which is somewhat
confusing.  I am using the system call memset() in kernel code written
for Red Hat 7.1(kernel 2.4).  I needed to make this code compatible with
Red Hat 6.2(kernel 2.2) and seem to be getting a unresolved symbol.
This is only happening in one place of the code in one file.  I am using
memset() in other areas of the code which does not lead to the problem.
If anyone can clue me in to what this possible can be, it would greatly
be appreciated.

Thank you in advance,
Michael

