Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTDDB0k (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTDDB0j (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 20:26:39 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:36324 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263609AbTDDBYK (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 20:24:10 -0500
Date: Fri, 4 Apr 2003 11:37:32 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66-mm3: hang and crash
Message-ID: <20030404013732.GA466@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried mm3 for the fun of it with two results:

1. If I leave my Xircom card in the PCMCIA slot, the kernel hangs at the 
   following point during boot:


Yenta IRQ list 00b8, PCI irq 10
Socket Status: 30000820
*hang*

   This does not happen if the card is not in plugged in.

2. After I booted, I logged into X, started up my mutts (6 of em) and
   started moving the mouse cursor about. Laptop turned itself off.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
