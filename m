Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTJXTKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTJXTKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:10:34 -0400
Received: from tomteboda.mdh.se ([130.243.76.141]:24260 "EHLO tomteboda.mdh.se")
	by vger.kernel.org with ESMTP id S262497AbTJXTK0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:10:26 -0400
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: r8169
Date: Fri, 24 Oct 2003 21:10:13 +0200
Message-ID: <049801c39a62$752c83f0$034d210a@sandos>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The r8169 driver in 2.4.22 with or without debian patches/acpi/usb
devices \
 
 ...

>> 2.6 will have the same problem.   I have a version that uses NAPI that
shouldn't \
>> hang. It seems to work fine, but didn't want to submit it without more
testing.
>
>
>Are you sure you're not thinking about 8139too, not r8169?

He sent me the source for 8139too, so he probably was mistaken. 8139too is
working fine in the same box, btw, so no problems there.

Any ideas regarding r8169 would be appreciated though.

---
John Bäckstrand 

