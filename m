Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131978AbRCVK63>; Thu, 22 Mar 2001 05:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131983AbRCVK6T>; Thu, 22 Mar 2001 05:58:19 -0500
Received: from [212.115.175.146] ([212.115.175.146]:19188 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S131978AbRCVK6H>; Thu, 22 Mar 2001 05:58:07 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F1064@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Alan Olsen <alan@clueserver.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: mysterious card
Date: Thu, 22 Mar 2001 11:56:52 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, the question is: does anyone know a place on the web where I can find
> specifications of ISA-slots? I need to know what is supposed to be
connected
> to
> the pins (1, 2, 6, etc.)
AO> It is supposed to do that!

Yes, I guess so!

AO> That sounds like the card that came with an old DOS debugger.

Not really. I found it in some high-end UNIX server (non-Linux).

AO> The old 8088 PCs did not have a reset switch. This was so you could do
AO> hardware breaks when the whole system was locked up.

This one triggers the I/O Channel Check pin (pin 1 (at the frame), component
side).
