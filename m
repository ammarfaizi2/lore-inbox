Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292316AbSCDLux>; Mon, 4 Mar 2002 06:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292320AbSCDLun>; Mon, 4 Mar 2002 06:50:43 -0500
Received: from [199.203.178.211] ([199.203.178.211]:33826 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S292316AbSCDLud> convert rfc822-to-8bit; Mon, 4 Mar 2002 06:50:33 -0500
content-class: urn:content-classes:message
Subject: FW: BUG in spinlock.h:133
Date: Mon, 4 Mar 2002 13:50:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
Message-ID: <DCC3761A6EC31643A3BAF8BB584B26CC0AAE8A@exchange.store-age.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-TNEF-Correlator: 
Thread-Topic: BUG in spinlock.h:133
Thread-Index: AcHDcqLI9ltHcC9REdaipAADR78XpQAAAYyA
From: "Alexander Sandler" <ASandler@store-age.com>
To: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I am getting a BUG in include/asm-i386/spinlock.h:133 when I am doing some I/O with driver I am working on. Does anyone has any idea what it can be?
The system is Linux RedHat 7.1 on dual CPU machine running kernel 2.4.16.

Alexandr Sandler.
