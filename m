Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTDVBeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 21:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTDVBeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 21:34:19 -0400
Received: from uida4-8.inav.uiowa.net ([64.6.83.152]:8576 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262771AbTDVBeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 21:34:18 -0400
Date: Mon, 21 Apr 2003 20:46:17 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI problems in 2.5.68
Message-ID: <20030422014615.GA599@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following errors when booting 2.5.68:

evevent-0286: ***Error: No installed handler for fixed event [00000000]
evevent-0286: ***Error: No installed handler for fixed event [00000003]
evgpe-0396: Error: acpi_ev_gpe_dispatch: No handler or method for GPE[ 0], disabling event
evgpe-0396: Error: 
And the kernel locks up hard.  Have to hit the reset switch.  These
  messages come just after mounting / readonly (thus, no logs exist;
  had to copy these down by hand).

This is on a Toshiba Satellite 1605CDS.  I'll try to provide whatever info
  I can, if you tell me what to look for (and I can find it; a lot goes
  by very fast)

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Isn't it illegal for Microsoft to tie any of its software products to its
  OS?"  --Rob Riggs on slashdot (www.slashdot.org) about Microsoft's order
  to cease and decist using Visual Fox Pro on Linux, a non-Microsoft OS.
"Yes. The penalty is dinner with no dessert." --Alien Being, response
