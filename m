Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWGKPTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWGKPTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWGKPTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:19:34 -0400
Received: from mail.gmx.de ([213.165.64.21]:28317 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750983AbWGKPTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:19:34 -0400
Cc: john stultz <johnstul@us.ibm.com>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Date: Tue, 11 Jul 2006 17:19:32 +0200
From: "Uwe Bugla" <uwe.bugla@gmx.de>
Message-ID: <20060711151932.19310@gmx.net>
MIME-Version: 1.0
Subject: patch for timer.c
To: Roman Zippel <zippel@linux-m68k.org>
X-Authenticated: #8359428
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
a thousand thanks for Roman's excellent work. which I tested as implementation in 2.6.18-rc1-mm1.
I can use again „vga=791“ as kernel parameter, I do not suffer any keyboard errors anymore at boot prompt, and the kernel boots very quickly.
Fantastic!

BUT: This is a „Pentium-4-only“ solution. On my file server, which is a Pentium 3 machine, the kernel stops booting and hangs the machine, no matter if I use framebuffer console with „vga=791“ or not.
Would you please try to find a fix for every architecture at any speed?

Regards

Uwe

-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
