Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268851AbRG3OzG>; Mon, 30 Jul 2001 10:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268830AbRG3Oy4>; Mon, 30 Jul 2001 10:54:56 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:63504 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S268842AbRG3Oyr>; Mon, 30 Jul 2001 10:54:47 -0400
Date: Mon, 30 Jul 2001 16:54:53 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: serial console and kernel 2.4
Message-ID: <20010730165453.A19255@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.7-cvs20010726
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I recently upgraded a linux box to the kernel 2.4.4 (from 2.2.18). This box
has no display and use the serial console. Since the upgrade I can see the
boot output on the remote console but I can't use the keyboard. Each time I
press a key, an interrupt is seen by the no-display machine but no char
appears in the console. 
Today I've upgraded an another box to 2.4.7 with a similar setup and I've
the same problem.

Is there something that I'm missing ? (something new with the kernel 2.4
that is required for a serial console that was not required with the 2.2 ?)

Is sombody else experienciong the same problem ?

Christophe


-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
