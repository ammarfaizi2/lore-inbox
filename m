Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUKWPt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUKWPt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKWPt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:49:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:30841 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261291AbUKWPUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:20:44 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.Nh0zRPbm8qA0VBxj@topspin.com>
	<200411231313.57758.arnd@arndb.de>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 23 Nov 2004 07:20:35 -0800
In-Reply-To: <200411231313.57758.arnd@arndb.de> (Arnd Bergmann's message of
 "Tue, 23 Nov 2004 13:13:57 +0100")
Message-ID: <52vfbw7fss.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][0/12] Initial submission of InfiniBand patches
 for review
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 15:20:41.0074 (UTC) FILETIME=[FE453520:01C4D16F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arnd> Patches 1, 3 and 5 didn't make it to lkml. Did you hit the
    Arnd> 100kb size limit for mails?

Ah, that must be what happened.  I was confused because gmane.org did
pick them up, but I think that's because gmane is also subscribed to
openib-general (which is cc'ed).

I'll reroll the patches, splitting the too-large pieces, and send
soon.

Thanks,
  Roland

