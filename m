Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129142AbRBVSG1>; Thu, 22 Feb 2001 13:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRBVSGR>; Thu, 22 Feb 2001 13:06:17 -0500
Received: from www.ansp.br ([143.108.25.7]:38416 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S129142AbRBVSGE>;
	Thu, 22 Feb 2001 13:06:04 -0500
Message-ID: <3A95470B.E273C637@ansp.br>
Date: Thu, 22 Feb 2001 15:06:19 -0200
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Building a new module from an existing one
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I plan to make a few changes to 3c90x.c (Ethhernet driver) located at
/usr/src/linux-2.2.16/drivers/net, in RH7. Since the correspondent
object file 3c90x.o resides in /lib/modules/2.2.16-20/net, I ask: how
shall I proceed in order to have the C file properly compiled and placed
in the right place, so that the modified version replaces the previous
one after system boot up ?

Thanks in advance,
Marcus.

