Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbRADQvI>; Thu, 4 Jan 2001 11:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRADQut>; Thu, 4 Jan 2001 11:50:49 -0500
Received: from pop.gmx.net ([194.221.183.20]:44737 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129697AbRADQuo>;
	Thu, 4 Jan 2001 11:50:44 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
To: linux-kernel@vger.kernel.org
Subject: 2.4.0prerelease-ac4 : still unresolved sysmpols 
Date: Tue, 2 Jan 2001 23:27:14 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01010223271400.01187@nmb>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,
I'm using 2.4.0prerelease-ac4. As far as I can see most things work fine 
besides the following:

1. after make modules_install I get:

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test12/kernel/drivers/block/fusion/mptlan.o
depmod:         unregister_fcdev
depmod:         init_fcdev


2. With 2.4.0-ac3 I had system-freese 3 times. 

kind regards

Norbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
