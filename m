Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWJVQXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWJVQXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWJVQXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:23:06 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:2255 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751167AbWJVQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:23:03 -0400
Date: Sun, 22 Oct 2006 18:22:51 +0200
To: Michael Chan <mchan@broadcom.com>, Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Message-ID: <20061022162251.GA11663@gamma.logic.tuwien.ac.at>
References: <20061021132239.GA29288@gamma.logic.tuwien.ac.at> <20061021.123814.106436476.davem@davemloft.net> <20061021233610.f190e0a8.akpm@osdl.org> <20061021234107.GA12918@gamma.logic.tuwien.ac.at> <1551EAE59135BE47B544934E30FC4FC093FC5D@NT-IRVA-0751.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061021233610.f190e0a8.akpm@osdl.org> <1551EAE59135BE47B544934E30FC4FC093FC5D@NT-IRVA-0751.brcm.ad.broadcom.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Sam, 21 Okt 2006, Michael Chan wrote:
> > 2.6.19-rc2	works
> > 2.6.19-rc2+patch does not work
> > 
> It doesn't make any sense.  This patch is totally benign and
> cannot cause the "No firmware running" and lockup that you
> reported.  Can you please double-check?

Ok, I cannot reproduce it anymore. No idea why it happened.

ANyway, with my current rc2+tg3 patch I have no problems, while with
rc2-mm2 I have the problems.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SHENANDOAH (n.)
The infinite smugness of one who knows they are entitled to a place in
a nuclear bunker.
			--- Douglas Adams, The Meaning of Liff
