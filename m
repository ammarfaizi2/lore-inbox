Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279035AbRKVNRd>; Thu, 22 Nov 2001 08:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279190AbRKVNRX>; Thu, 22 Nov 2001 08:17:23 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:41993 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S279035AbRKVNRT>; Thu, 22 Nov 2001 08:17:19 -0500
Date: Thu, 22 Nov 2001 14:17:18 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Marcus Grando <marcus@big.univali.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Input/output error
In-Reply-To: <5.1.0.14.1.20011122105002.00ab7678@mail.big.univali.br>
Message-ID: <Pine.LNX.4.33.0111221415490.1518-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Marcus Grando wrote:

> On try start syslog deamon occur this errrors "Input/output error" on many archives /var directory.

Try to run fsck on the /var partition. Also you should check the disk 
for bad blocks. What output do you get from the kernel ('dmesg', 
/var/log/messages etc.)?

It could be a bad disk developing bad sectors.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
DISCLAIMER: Microsoft, Windows, Windows 98, Bugs, Lacking features, IRQ
conflicts, System crashes, Non-functional multitasking, the Y2K problem
and the Blue Screen of Death are registered trademarks of
Microsoft, Corp., Redmond, USA.
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

