Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDQJqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 05:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTDQJqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 05:46:34 -0400
Received: from ns0.epita.net ([163.5.254.20]:28814 "HELO neo.epita.net")
	by vger.kernel.org with SMTP id S261296AbTDQJqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 05:46:33 -0400
Message-ID: <001901c304c8$93d27740$3602a8c0@team.3ie.org>
From: "Pestouille" <pestouille@3ie.org>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.20 AT keyboard present ?
Date: Thu, 17 Apr 2003 12:03:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not an expert in kernel compilation but I had this problem :

keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?

My system is as follows :

- Dell dimension 8250
- P4 3.06 with HT (enabled in bios)
- 512 RDRAM
- DD Ide 120 Go
- ATI Radeon 9700 Pro
- Debian with lastest packages

This problem occurs with a 2.4.20 kernel. With the basic 2.2.20 provided in
the woody, the system works without problems.
The thing really odd is when using a 2.4.20 patched kernel for gentoo, I've
got the keyboard working but the X don't let me use my keyboard either my
mouse.

I also tried using a 2.4.21-pre7 without success.

I'm open to any suggestions ;)

PS : my kernel is compiled with SMP support and my keyboard and mouse are
PS/2.

I didn't subscribe to the lkml so If you would be nice enough to send me
answer by mail.

Thank you.

--
Adrien Pestel

