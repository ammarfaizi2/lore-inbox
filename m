Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRAMHQ3>; Sat, 13 Jan 2001 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135542AbRAMHQU>; Sat, 13 Jan 2001 02:16:20 -0500
Received: from cr125998-a.ktchnr1.on.wave.home.com ([24.112.244.165]:64004
	"HELO ns.penultima.org") by vger.kernel.org with SMTP
	id <S130663AbRAMHQH>; Sat, 13 Jan 2001 02:16:07 -0500
Date: Sat, 13 Jan 2001 02:15:47 -0500
From: Isaac Connor <iconnor@penultima.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 boot failure on Micronic W6Li
Reply-To: iconnor@penultima.org
X-Mailer: Spruce 0.7.5 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010113071614Z130663-692+339@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.0 doesn't seem to want to boot on my W6Li with two PPRO 150's.  
THis machine has no problems with 2.2 kernels, and is currently running
2.2.17.

It uncompresses, and prints that it is booting, then locks hard.  Must
reset.

I have tried the noapic option, with no effect.

I have searched for information on this problem, but I can't seem to find
anything.  I guess no one else is having this problem ona W6Li.

Please help.

Isaac Connor
iconnor@penultima.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
