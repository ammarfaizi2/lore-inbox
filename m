Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRITHzf>; Thu, 20 Sep 2001 03:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274357AbRITHzZ>; Thu, 20 Sep 2001 03:55:25 -0400
Received: from gateway-2.hyperlink.com ([213.52.152.2]:21516 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S270724AbRITHzO>; Thu, 20 Sep 2001 03:55:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Martin Brooks <martin@jtrix.com>
Reply-To: martin@jtrix.com
Organization: Jtrix Ltd 
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre12 build error
Date: Thu, 20 Sep 2001 08:55:38 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15jygW-0007gN-00@obelix.intranet.hyperlink.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init/main.o: In function `smp_init':
init/main.o(.text.init+0x74d): undefined reference to 
`IO_APIC_init_uniprocessor'
make: *** [vmlinux] Error 1


I'm not subscribed, please CC.
-- 

Martin A. Brooks,  Systems Administrator
------------------------------------------------
Jtrix Ltd		t: +44 207 395 4990
57-59 Neal Street	f: +44 207 395 4991
Covent Garden		e: martin@jtrix.org
London WC2H 9PJ		w: http://www.jtrix.org

Running Windows: while (problem){ reboot; last if
Upgrade||ServicePack||MassivelyPublicisedExploit;} restart;
