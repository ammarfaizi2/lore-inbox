Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313568AbSEJSqq>; Fri, 10 May 2002 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315799AbSEJSqp>; Fri, 10 May 2002 14:46:45 -0400
Received: from smtp1.home.se ([195.66.35.200]:15500 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id <S313568AbSEJSqo>;
	Fri, 10 May 2002 14:46:44 -0400
Message-ID: <005201c1f853$040428c0$0319450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: [OT] hardware question
Date: Fri, 10 May 2002 20:46:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My problems regarding a SB16 isa on a 486 seems to be
coming from the use of a pentium overdrive 80mhz
instead of a DX33. It is _only_ when trying to do sound
that everything breaks, otherwise its really stable.
Similar results were achieved in windows. My hunch is
that the cpu is in some way making dma or interrupts
unstable, or maybe the entire ISA bus. I tried to read
a mp3 from floppy aswell, but that also crashed. Its
only in linux/windows that the overdrive causes
problems, the creative dos diagnose.exe can play fine
even with the overdrive. Any ideas to this weirdness?

Im not on the list so answer in private.

---
John Bäckstrand


