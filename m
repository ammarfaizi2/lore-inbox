Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268089AbTBYQ4u>; Tue, 25 Feb 2003 11:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268091AbTBYQ4u>; Tue, 25 Feb 2003 11:56:50 -0500
Received: from host161-23.pool8017.interbusiness.it ([80.17.23.161]:61607 "EHLO
	pcfire.nergal") by vger.kernel.org with ESMTP id <S268089AbTBYQ4t>;
	Tue, 25 Feb 2003 11:56:49 -0500
Message-ID: <004501c2dcf0$8e2757c0$570610ac@pclab1>
From: "engidudu" <usbhc_dev@nergal.it>
To: <linux-kernel@vger.kernel.org>
Subject: SL811HS driver
Date: Tue, 25 Feb 2003 18:08:45 +0100
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

Hi,

we have modified the linux driver for SL811 USB HOST Controller by CYPRESS.
We have improved the program's flow:
- interrupt handler,
- double buffering.
It works well during writing transactions, but we still have problems
implementing
double buffering during reading transactions.
We would like to send you our source code to attend the next kernel release.
These codes work on uClinux (kernel 2.4) too.

How do we have to send these codes?

Thanks.

       Linux Nergal Group.

