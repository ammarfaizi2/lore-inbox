Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278458AbRJOWiO>; Mon, 15 Oct 2001 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278465AbRJOWiE>; Mon, 15 Oct 2001 18:38:04 -0400
Received: from jalon.able.es ([212.97.163.2]:35010 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S278458AbRJOWhs>;
	Mon, 15 Oct 2001 18:37:48 -0400
Date: Tue, 16 Oct 2001 00:38:12 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Status of ServerWorks UDMA
Message-ID: <20011016003812.A28638@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have just installed a system with kernel 2.4.20, and it stops booting
with a message like:

	Controller is in an impossible state. Disable UDMA.

Board is a SuperMicro 370DLE (SW LE chipset). I have tried disabling 
ide channels on the bios, but kernel still sees them. I have tried to
boot with ide0=nodma (is this options real, or I just have invented it ??)
No solution.

Any ideas ?

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.12-ac2-beo #1 SMP Mon Oct 15 00:23:19 CEST 2001 i686
