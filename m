Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKHQ4n>; Thu, 8 Nov 2001 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKHQ4d>; Thu, 8 Nov 2001 11:56:33 -0500
Received: from [62.14.235.6] ([62.14.235.6]:31748 "HELO [62.14.235.6]")
	by vger.kernel.org with SMTP id <S275270AbRKHQ4U>;
	Thu, 8 Nov 2001 11:56:20 -0500
From: "Drizzt Do'Urden" <drizzt.dourden@iname.com>
To: "Doug McNaught" <doug@wireboard.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Module Licensing? (thinking a little more)
Date: Thu, 8 Nov 2001 18:00:45 +0100
Message-ID: <NLEDJBJHJDOPHJOIBBAFOEIOCGAA.drizzt.dourden@iname.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
In-Reply-To: <m3bsidxnm4.fsf@belphigor.mcnaught.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yes, clause 3.a) "machine readable source code". A .s file is, "machine
readable source code" by the assembler and by people that have enough time
to lost.. It is like head.S, but using numeric labels and other stuff of
that kind.

Btw I don't understand exactly the problem with the use of  asm code (in
opcodes or in nemonics) and the GPL in this particular case . To me, it's
"machine readable source code" by the assembler and if it's compilation
produces exactly the same executable, and don't see the problem.

It's a nighmare to debug and mantain, but it's the problem who made the
"asm" modulo not  the kernel people.

Saludos
Drizzt

