Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSF0Xxa>; Thu, 27 Jun 2002 19:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSF0Xx3>; Thu, 27 Jun 2002 19:53:29 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:135 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S317020AbSF0Xx3>;
	Thu, 27 Jun 2002 19:53:29 -0400
Message-ID: <012901c21e36$3fc0c360$0201a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [lb OT] BSOD in Linux? 
Date: Fri, 28 Jun 2002 01:56:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my testbox (2.5.24-dj2) with rivafb turned on, after some fights with
iptables and svgalib, I finnaly said 'Work is over for today' and pressed
Ctrl-Alt-Del. I was on first console. Then i changed to second console,
keventd oopsed (which wasn't strange for me, this kernel usually oopses
while shutting down). Alt-SysRq-S, Alt-SysRq-U. But then, when I was trying
to change to 1st console the only thing I could see was... a BLUE SCREEN!!!.
My god, they are here. They're watching us. They're inserting pieces of code
into BK repository while Linus is sleeping!!! I'm waiting for 2.5.25....
:->P
Witold 'adasi' Krecicki


