Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130868AbRAFLHT>; Sat, 6 Jan 2001 06:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRAFLHJ>; Sat, 6 Jan 2001 06:07:09 -0500
Received: from [62.26.212.98] ([62.26.212.98]:4112 "EHLO top.mynetix.de")
	by vger.kernel.org with ESMTP id <S130868AbRAFLGz>;
	Sat, 6 Jan 2001 06:06:55 -0500
Message-Id: <200101061105.MAA06227@top.mynetix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: "Andreas Kotowicz" <koto@mynetix.de>
To: linux-kernel@vger.kernel.org
Subject: can't mount zip drive with kernel 2.4.0
X-Mailer: Pronto v2.2.2 On linux
Date: 06 Jan 2001 12:07:30 CET
Reply-To: "Andreas Kotowicz" <koto@mynetix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

I just have installed kernel 2.4.0 and everything except my zipdrive
works (ppa driver).
when I do a "mount /dev/sda4 /mnt/zip" I get following error: "mount:
/dev/sda4 has wrong major or minor number".

I use following software:

egcs-2.91.66
GNU Make version 3.78.1
GNU ld version 2.9.5
util-linux 2.10o
modutils 2.4.0
e2fsprogs 1.19
redhat 6.2

when I update util-linux to version 2.10.p I get this error: "mount:
/dev/sda4: unknown device".

Andreas.

PS: I'm not subscribed to linux-kernel@vger.kernel.org. please send me
answers with Cc.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
