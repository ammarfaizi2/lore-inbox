Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTD3Moa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTD3Moa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:44:30 -0400
Received: from lily.comarch.pl ([195.116.193.4]:22280 "EHLO lily.comarch.pl")
	by vger.kernel.org with ESMTP id S262160AbTD3Mo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:44:28 -0400
Message-ID: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
From: "Wojciech Sobczak" <Wojciech.Sobczak@comarch.pl>
To: <linux-kernel@vger.kernel.org>
Subject: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
Date: Wed, 30 Apr 2003 14:56:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helo,
I'm trying to boot from linux kernel 2.4 tree
i've installed rh 7.1 dist, but system seems only 3 procesors, so i made
2.4.20 kernel with smp without NUMA support and i saw 4 processors. Next
2.4.20 with numa support, and system hangs on mounting root filesystem (no
scsi devices found, ide devices lost interruption, no keyboard found etc
etc)
Next 2.4.21-rc1-ac3 without NUMA, 3-processors available
with NUMA support and summit/exa support and clustered apic support kernel
boots, found scsi devices but hangs on it with lost interruption, also with
ide devices and so on
machine has 4 HT processors and 8GB of RAM
any ideas or help?

i don't wat to use 2.5.x kernel.....

regards

Sobczak Wojciech

