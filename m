Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRC0M6w>; Tue, 27 Mar 2001 07:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRC0M6l>; Tue, 27 Mar 2001 07:58:41 -0500
Received: from limes.hometree.net ([194.231.17.49]:46700 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S131248AbRC0M6e>; Tue, 27 Mar 2001 07:58:34 -0500
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2001 12:36:18 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <99q1g2$air$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Reply-To: hps@tanstaafl.de
Subject: Promise RAID controller howto?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know, that this is a FAQ and the Promise RAID controller card is not
yet usable as a RAID board under Linux 2.x but is there a way to use
the controller just like the UltraATA 100 controller?

I know, that "input high == UltraATA core, input low = RAID core"
according to Andre Hedrick but I really don't care about the RAID
core. I want to use this controller to drive JBOD.

Can one do this? The disks need not to be interchangeable to other
controllers.  Just be accessible.

2.2 solutions preferred, 2.4 ok.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
