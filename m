Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbREZLmx>; Sat, 26 May 2001 07:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbREZLmn>; Sat, 26 May 2001 07:42:43 -0400
Received: from eax.student.umd.edu ([129.2.228.67]:56330 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S262637AbREZLm1>; Sat, 26 May 2001 07:42:27 -0400
Date: Sat, 26 May 2001 07:44:31 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: David =?ISO-8859-1?Q?G=F3mez ?= <davidge@jazzfree.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>, <mwm@i.am>
Subject: [2.4.5][patch] Re: ov511 driver doesn't compile
In-Reply-To: <Pine.LNX.4.21.0105261250100.8159-100000@fargo>
Message-ID: <Pine.LNX.4.33.0105260738170.4141-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ov511.c: In function `ov511_read_proc':
> ov511.c:340: `version' undeclared (first use in this function)
> ov511.c:340: (Each undeclared identifier is reported only once
> ov511.c:340: for each function it appears in.)
> make[2]: *** [ov511.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.5/drivers/usb'

hello, this patch should fix it

	http://www.eax.com/patches/linux-245-ov511-diff

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers



