Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280895AbRKCAhD>; Fri, 2 Nov 2001 19:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280896AbRKCAgn>; Fri, 2 Nov 2001 19:36:43 -0500
Received: from jalon.able.es ([212.97.163.2]:904 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S280895AbRKCAgk>;
	Fri, 2 Nov 2001 19:36:40 -0500
Date: Sat, 3 Nov 2001 01:36:32 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ext3 for pre7 ?
Message-ID: <20011103013632.A2427@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have tried to adapt the ext3 patch for pre6 to pre7, but many things
in the buffer and cache sections (vmscan.c and so on) have changed...
I also saw in CVS that there have been changes to make it work on pre7. 
But I did not guess how to make a patch from CVS.

Anyone out there has it ?

BTW: I see there are a bunch of chages in ext3 patch outside its own
fs subtree (try_to_free_pages and so on). Why are not integrated in
mainline ?

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre7-beo #1 SMP Fri Nov 2 20:26:59 CET 2001 i686
