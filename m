Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130759AbRAYUqG>; Thu, 25 Jan 2001 15:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAYUp4>; Thu, 25 Jan 2001 15:45:56 -0500
Received: from gate.unige.ch ([129.194.8.77]:16830 "EHLO gate.unige.ch")
	by vger.kernel.org with ESMTP id <S130759AbRAYUoZ>;
	Thu, 25 Jan 2001 15:44:25 -0500
Date: Thu, 25 Jan 2001 21:44:21 +0100
From: Pfenniger Daniel <daniel.pfenniger@obs.unige.ch>
Subject: Oops with bonding (2.4.0, 2.4.0-ac11)
To: linux-kernel@vger.kernel.org
Message-id: <3A709025.2FF95BA1@obs.unige.ch>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: fr-CH, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel oops when the bond0 device is shut down (for example at reboot). 

Linux 2.4.0 and 2.4.0-ac11, gcc 2.9.5-2. 
Pentium II SMP, supplied tulip driver for tulip cards with 21140 or 21143 chips

This doesn't happen with 2.2.18

 	Daniel Pfenniger
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
