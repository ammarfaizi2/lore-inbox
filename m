Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWJORvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWJORvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWJORvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:51:10 -0400
Received: from mga03.intel.com ([143.182.124.21]:36768 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1422646AbWJORvJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:51:09 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,313,1157353200"; 
   d="scan'208"; a="131263933:sNHT18513306"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: config TELCLOCK
Date: Sun, 15 Oct 2006 10:51:04 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D030B5000@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: config TELCLOCK
thread-index: AcbwP2V28CkVdhXCSBGy9lMyZoprIgAQopWg
From: "Gross, Mark" <mark.gross@intel.com>
To: <geert@linux-m68k.org>
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Oct 2006 17:51:06.0131 (UTC) FILETIME=[7D10DE30:01C6F082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, the telcom clock is currently only on the MPCBL0010.  
http://www.intel.com/design/telecom/products/cbp/atca/9445/overview.htm

It's i386/x86_64 capable platform.

Does this help?

--mgross

>-----Original Message-----
>From: geert@linux-m68k.org [mailto:geert@linux-m68k.org]
>Sent: Sunday, October 15, 2006 2:51 AM
>To: Gross, Mark
>Cc: Linux Kernel Development
>Subject: config TELCLOCK
>
>	Hi Mark,
>
>Can you tell us on which platforms the `Telecom clock driver for
MPBL0010 ATCA
>SBC' is used, so we can add proper dependencies to
drivers/char/Kconfig?
>
>Thanks!
>
>Gr{oetje,eeting}s,
>
>						Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
hacker. But
>when I'm talking to journalists I just say "programmer" or something
like that.
>							    -- Linus
Torvalds
