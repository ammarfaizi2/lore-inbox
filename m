Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUDVLB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUDVLB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbUDVK7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:59:40 -0400
Received: from [203.199.202.17] ([203.199.202.17]:49924 "EHLO
	pub.isofttechindia.com") by vger.kernel.org with ESMTP
	id S263926AbUDVKyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:54:45 -0400
Message-ID: <02e301c42857$f7740c60$cb00a8c0@megharaj>
From: "Megharaj" <megharaj@isofttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: GCC tool chain 3.3.2 problem.
Date: Thu, 22 Apr 2004 16:22:54 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i fallowed the instruction to build the GCC tool  chain 3.3.2 given in the
fallowing link.

http://blackfin.uclinux.org/docman/view.php/18/43/Build%20instructions.doc

after building i compiled the uclinux distribution with nisa-elf gcc tool
chain it got compiled properly.

but when i am compiling the same uclinux distribution with new gcc tool
chain 3.3.2 it shows that the error header file like stddef.h are missing.

if any one could give me the details abt  what is the problem with new gcc
tool chain 3.3.2 or do i  am missing something in building the gccc tool
chin 3.3.2.  it wud be very helpful.


thanx n ragards
megharaj.



