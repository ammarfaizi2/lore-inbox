Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTIBQ6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIBQ6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:58:06 -0400
Received: from bartek.tu.kielce.pl ([81.26.6.5]:27785 "EHLO
	bartek.tu.kielce.pl") by vger.kernel.org with ESMTP id S264054AbTIBQz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:55:59 -0400
From: Tomasz =?ISO-8859-1?Q?=20B=B1tor?= <tomba@bartek.tu.kielce.pl>
Date: Tue, 2 Sep 2003 18:55:38 +0200
To: linux-kernel@vger.kernel.org
Subject: What is the SiI 0680 chipset status?
Message-ID: <20030902165537.GA1830@bartek.tu.kielce.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi to all.
I recently got MiNt PCI IDE ATA/133 RAID controller based on SiI 0680
chipset. I browsed through the archives and I know that the driver is
known to be broken and simply doesn't work.

That was some time ago, meanwhile there were some fixes/hdparm
almost-solutions, but none of them seems to work. I remember that
Andre Hendrick said he's talking with SiI guys to find a final
solution, but no more info after that...

Therefore my question is: what is the current status of this driver?
Are there any patches available? Or I will have to just buy another
controller? (No problems with HPT or Promise?)

t.

ps. my problems are "standard" (lost interrupts, timeouts, read_intr
errors etc.) and were described on this list by several other people.
I use almost vanilla 2.4.22 (only with Openwall patches)

-- 
  Tomasz B±tor  e-mail: tomba@bartek.tu.kielce.pl  ICQ: 101194886
 ------ ---- -- - -  -    -   -  -  -   -    -  - - -- ---- ------
              "What do you mean, they threw it back?"
                    -- last words in a RPG game
